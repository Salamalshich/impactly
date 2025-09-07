<?php

namespace App\Http\Controllers;

use App\Models\Event;
use App\Models\VolunteerEventParticipation;
use App\Models\VolunteerRegistration;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class EventController extends Controller
{

    // إنشاء فعالية جديدة
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title'           => 'required|string|max:255',
            'description'     => 'required|string',
            'start_date'      => 'required|date',
            'end_date'        => 'required|date|after_or_equal:start_date',
            'location'        => 'required|string',
            'category'        => 'required|string',
            'max_volunteers'  => 'required|integer|min:1',
            'district_id' => 'required|exists:districts,id',
        ]);

        $event = Event::create(array_merge($validated, [
            'creator_id' => Auth::id(),
        ]));

        return response()->json($event, 201);
    }

    // جلب كل الفعاليات
    public function index()
    {
        return response()->json(Event::with(['creator','volunteerParticipations','pledges.user','volunteerParticipations.user','district.governorate'])->get());
    }

    // جلب فعالية واحدة
    public function show($id)
    {
        $event = Event::with(['creator','volunteerParticipations','pledges.user','volunteerParticipations.user'])->findOrFail($id);
        return response()->json($event);
    }

   // تحديث فعالية
    public function update(Request $request, $id)
    {
        $event = Event::findOrFail($id);

        // شرط: ما يعدل إلا صاحب الفعالية
        if ($event->creator_id !== Auth::id()) {
            return response()->json(['message' => 'غير مسموح'], 403);
        }

        $validated = $request->validate([
            'title'           => 'sometimes|string|max:255',
            'description'     => 'sometimes|string',
            'start_date'      => 'sometimes|date',
            'end_date'        => 'sometimes|date|after_or_equal:start_date',
            'location'        => 'sometimes|string',
            'category'        => 'sometimes|string',
            'max_volunteers'  => 'sometimes|integer|min:1',
            'district_id' => 'required|exists:districts,id',
            'rejection_reason'=> ''
        ]);

        // رجع الحالة pending بكل تحديث
        $validated['status'] = 'pending';
        $validated['rejection_reason'] = null;

        $event->update($validated);

        return response()->json($event);
    }

    // حذف فعالية
    public function destroy($id)
    {
        $event = Event::findOrFail($id);

        if ($event->creator_id !== Auth::id()) {
            return response()->json(['message' => 'غير مسموح'], 403);
        }

        $event->delete();
        return response()->json(['message' => 'تم الحذف بنجاح']);
    }


    // الفعاليات الخاصة بي (حسب التوكين)
   public function myEvents()
{
    $events = Event::withCount('volunteerParticipations')
        ->with(['district.governorate'])
        ->where('creator_id', Auth::id())
        ->get()
       ->map(function ($event) {
            $organizerName = $event->creator?->association_name
                ? $event->creator->association_name
                : $event->creator?->name;

            return [
                'id' => $event->id,
                'title' => $event->title,
                'description' => $event->description,
                'start_date' => $event->start_date,
                'end_date' => $event->end_date,
                'location' => $event->location,
                'category' => $event->category,
                'max_volunteers' => $event->max_volunteers,
                'creator_id' => $event->creator_id,
                'district_id' => $event->district_id,
                'status' => $event->status,
                'rejection_reason' => $event->rejection_reason,
                'created_at' => $event->created_at,
                'updated_at' => $event->updated_at,
                'deleted_at' => $event->deleted_at,
                'volunteer_registrations_count' => $event->volunteerParticipations()->count(),
                'district_name' => $event->district?->name,
                'governorate_name' => $event->district?->governorate?->name,
                'district' => $event->district,
                'organizer_name' => $organizerName,
            ];
        });
    return response()->json($events);
}

public function eventsByDistrict()
{
    $user = Auth::user();

    if (!$user->district_id) {
        return response()->json(['message' => 'المستخدم لا يملك حي مرتبط'], 400);
    }

    $events = Event::withCount(['volunteerParticipations as volunteer_registrations_count' => function($query) {
        $query->where('status', '!=', 'cancelled');
    }])
        ->with(['district:id,name,governorate_id', 'district.governorate:id,name', 'volunteerParticipations'])
        ->where('district_id', $user->district_id)
        ->where('status', 'approved')
        ->where('creator_id', '!=', $user->id)
        ->get()
        ->map(function ($event) use ($user) {
            $organizerName = $event->creator?->association_name
                ? $event->creator->association_name
                : $event->creator?->name;

            // تحقق إذا المستخدم مسجل بالفعالية
            $isRegistered = $event->volunteerParticipations
                ->where('user_id', $user->id)
                ->isNotEmpty();

            return [
                'id' => $event->id,
                'title' => $event->title,
                'description' => $event->description,
                'start_date' => $event->start_date,
                'end_date' => $event->end_date,
                'location' => $event->location,
                'category' => $event->category,
                'max_volunteers' => $event->max_volunteers,
                'creator_id' => $event->creator_id,
                'district_id' => $event->district_id,
                'status' => $event->status,
                'rejection_reason' => $event->rejection_reason,
                'created_at' => $event->created_at,
                'updated_at' => $event->updated_at,
                'deleted_at' => $event->deleted_at,
                'volunteer_registrations_count' => $event->volunteer_registrations_count,
                'district_name' => $event->district?->name,
                'governorate_name' => $event->district?->governorate?->name,
                'organizer_name' => $organizerName,
                'is_registered' => $isRegistered, // <-- هذا الـ key الجديد
            ];
        });

    return response()->json($events);
}



    public function updateStatus(Request $request, $id)
    {
        $event = Event::findOrFail($id);

        // تحقق أن المستخدم الحالي عنده دور admin
        if (!Auth::user()->hasRole('Admin')) {
            return response()->json(['message' => 'غير مسموح'], 403);
        }
        if ($event->status === 'completed') {
            return response()->json(['message' => 'لا يمكن تعديل حدث مكتمل'], 400);
        }
        $validated = $request->validate([
            'status'           => 'required|in:pending,approved,rejected,completed',
            'rejection_reason' => 'nullable|string',
        ]);

        $event->update($validated);

        return response()->json($event);
    }
public function myRegisteredEvents()
{
    $user = Auth::user();

    // جلب جميع تسجيلات المستخدم مع علاقات الحدث
    $registrations = VolunteerEventParticipation::with(['event.district.governorate', 'event.creator'])
        ->where('user_id', $user->id)
        ->get();

    $events = $registrations->map(function ($registration) {
        $event = $registration->event;

        $organizerName = $event->creator?->association_name
            ? $event->creator->association_name
            : $event->creator?->name;

        return [
            'registration' => [
                'id' => $registration->id,
                'status' => $registration->status,
                'hours_worked' => $registration->hours_worked,
                'feedback' => $registration->feedback,
                'rating' => $registration->rating,
                'created_at' => $registration->created_at,
                'updated_at' => $registration->updated_at,
            ],
            'event' => [
                'id' => $event->id,
                'title' => $event->title,
                'description' => $event->description,
                'start_date' => $event->start_date,
                'end_date' => $event->end_date,
                'location' => $event->location,
                'category' => $event->category,
                'max_volunteers' => $event->max_volunteers,
                'creator_id' => $event->creator_id,
                'district_id' => $event->district_id,
                'status' => $event->status,
                'rejection_reason' => $event->rejection_reason,
                'created_at' => $event->created_at,
                'updated_at' => $event->updated_at,
                'deleted_at' => $event->deleted_at,
                'volunteer_registrations_count' => $event->volunteerParticipations()
                    ->where('status', '!=', 'cancelled')
                    ->count(),
                'district_name' => $event->district?->name,
                'governorate_name' => $event->district?->governorate?->name,
                'organizer_name' => $organizerName,
                'is_registered' => true,
            ]
        ];
    });

    return response()->json($events);
}


}
