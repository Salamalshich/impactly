<?php

namespace App\Http\Controllers;

use App\Models\Event;
use App\Models\VolunteerEventParticipation;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class VolunteerEventController extends Controller
{
    private string $aesKey = '1234123412341234';
    private string $aesIv  = '1234567890abcdef';

    // تسجيل المتطوع للفعالية
    public function register(Request $request, $eventId)
    {
        $event = Event::findOrFail($eventId);
        $userId = Auth::id();

        // تحقق من عدم التسجيل المسبق
        $exists = VolunteerEventParticipation::where('user_id', $userId)
            ->where('event_id', $eventId)
            ->exists();

        if ($exists) {
            return response()->json(['message' => 'You are already registered for this event'], 400);
        }

        // تحقق من أي تقاطع بالفعاليات الأخرى
        $userEvents = Event::whereHas('volunteerParticipations', function ($query) use ($userId) {
                $query->where('user_id', $userId);
            })
            ->get();

        foreach ($userEvents as $e) {
            if (($event->start_date <= $e->end_date) && ($event->end_date >= $e->start_date)) {
                return response()->json(['message' => 'You cannot register for two events that overlap in time'], 400);
            }
        }

        // إنشاء المشاركة
        $participation = VolunteerEventParticipation::create([
            'user_id' => $userId,
            'event_id' => $eventId,
            'status' => 'registered',
        ]);

        return response()->json($participation, 201);
    }

    // إلغاء التسجيل
    public function withdraw($participationId)
    {
        $participation = VolunteerEventParticipation::where('id', $participationId)
            ->where('user_id', Auth::id())
            ->firstOrFail();

        $participation->update(['status' => 'cancelled']);

        return response()->json(['message' => 'تم إلغاء التسجيل في الفعالية']);
    }

    // تقديم Feedback
    public function updateFeedback(Request $request, $participationId)
    {
        $participation = VolunteerEventParticipation::where('id', $participationId)
            ->where('user_id', Auth::id())
            ->firstOrFail();

        if ($participation->status !== 'attended') {
            return response()->json(['message' => 'لا يمكن تقديم التقييم إلا بعد الحضور'], 403);
        }

        $validated = $request->validate([
            'feedback' => 'nullable|string',
            'rating'   => 'nullable|integer|min:1|max:5',
        ]);

        $participation->update($validated);

        return response()->json($participation);
    }

    // المنظم يتحقق من الساعات ويعتمدها قبل مراجعة الادمن
    public function verifyHours(Request $request, $participationId)
    {
        $participation = VolunteerEventParticipation::findOrFail($participationId);
        $event = $participation->event;

        if ($event->creator_id !== Auth::id()) {
            return response()->json(['message' => 'غير مسموح'], 403);
        }

        $validated = $request->validate([
            'hours_worked' => 'required|integer|min:0',
        ]);

        $participation->hours_worked = $validated['hours_worked'];
        $participation->status = "attended";
        $participation->verified_by = Auth::id();

        // 🟢 نحسب وقت الخروج الجديد بناءً على check_in
        if ($participation->check_in && $participation->hours_worked > 0) {
            $hours = (int) $participation->hours_worked;
            $participation->check_out = $participation->check_in
                ->copy()
                ->addHours($hours);
        }

        $participation->save();

        return response()->json([
            'message' => 'Participation verified by organizer',
            'participation' => $participation
        ]);
    }


    public function volunteerNoShow(Request $request, $participationId)
    {
        $participation = VolunteerEventParticipation::findOrFail($participationId);
        $event = $participation->event;

        if ($event->creator_id !== Auth::id()) {
            return response()->json(['message' => 'غير مسموح'], 403);
        }

        $participation->hours_worked = null;
        $participation->status = "no_show";
        $participation->verified_by = Auth::id();
        $participation->check_out=null;
        $participation->check_in=null;

        $participation->save();

        return response()->json([
            'message' => 'Participation verified by organizer',
            'participation' => $participation
        ]);
    }


    public function scanQr(Request $request)
    {
        $user = Auth::user();
        $request->validate(['encrypted_data' => 'required|string']);
        $payload = $this->decryptAES($request->encrypted_data);

        if (!$payload || !isset($payload['event_id']) || !isset($payload['type'])) {
            return response()->json(['message' => 'Invalid QR payload'], 400);
        }

        $event = Event::findOrFail($payload['event_id']);
        $participation = VolunteerEventParticipation::firstOrCreate([
            'user_id' => $user->id,
            'event_id' => $event->id,
        ]);

        if ($payload['type'] === 'check_in') {
            if ($participation->check_in) return response()->json(['message' => 'Already checked in'], 400);

            $participation->check_in = isset($payload['time']) ? Carbon::parse($payload['time']) : now();
            $participation->save();

            return response()->json(['message' => 'Checked in successfully', 'participation' => $participation]);
        }

        if ($payload['type'] === 'check_out') {
            if (!$participation->check_in) return response()->json(['message' => 'Cannot check out before check in'], 400);
            if ($participation->check_out) return response()->json(['message' => 'Already checked out'], 400);

            $participation->check_out = isset($payload['time']) ? Carbon::parse($payload['time']) : now();
            $participation->hours_worked = $participation->check_in->diffInHours($participation->check_out);
            $participation->save();

            return response()->json(['message' => 'Checked out successfully', 'participation' => $participation]);
        }

        return response()->json(['message' => 'Invalid type'], 422);
    }

    public function completeEvent($eventId)
    {
        $event = Event::findOrFail($eventId);

        if ($event->creator_id !== Auth::id()) {
            return response()->json(['message' => 'غير مسموح'], 403);
        }

        if ($event->status === 'approved') {
             $event->status = 'completed';
        $event->save();

        $participations = $event->volunteerParticipations()->get();

        foreach ($participations as $p) {
            if ($p->check_in && $p->check_out) {
                //  عندو حضور وخروج
                $p->status = 'attended';
                $p->verified_by = $p->verified_by ?? Auth::id();
            } else {
                //  ما عندو حضور وخروج
                $p->status = 'no_show';
                $p->verified_by = $p->verified_by ?? Auth::id();
            }

            $p->save();
        }

        // رجع participations بعد التحديث
        $participations = $event->volunteerParticipations()->get();

        return response()->json([
            'message' => 'Event completed, participations updated',
            'participations' => $participations
        ]);
        }else{
            return response()->json(['message' => 'لا يمكن تغيير حالة الفعالية الا في حالة الموافقة عليها'], 403);

        }


    }



    private function decryptAES(string $encryptedBase64): ?array
    {
        $cipher = "AES-128-CBC";
        $decoded = base64_decode($encryptedBase64);
        $decrypted = openssl_decrypt($decoded, $cipher, $this->aesKey, OPENSSL_RAW_DATA, $this->aesIv);
        return $decrypted ? json_decode($decrypted, true) : null;
    }
}
