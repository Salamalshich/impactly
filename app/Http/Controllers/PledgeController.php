<?php

namespace App\Http\Controllers;

use App\Models\Pledge;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PledgeController extends Controller
{
     // إنشاء تعهد جديد
    public function store(Request $request)
    {
        $validated = $request->validate([
            'event_id'  => 'required|exists:events,id',
            'item_name' => 'required|string|max:255',
            'quantity'  => 'required|integer|min:1',
            'notes'     => 'nullable|string',
        ]);

        $pledge = Pledge::create([
            'user_id'   => Auth::id(),
            'event_id'  => $validated['event_id'],
            'item_name' => $validated['item_name'],
            'quantity'  => $validated['quantity'],
            'notes'     => $validated['notes'] ?? null,
        ]);

        return response()->json($pledge, 201);
    }

     // تعديل تعهد (بس إذا كان لسا pending)
    public function update(Request $request, $id)
    {
        $pledge = Pledge::findOrFail($id);

        if ($pledge->user_id !== Auth::id()) {
            return response()->json(['message' => 'غير مسموح'], 403);
        }

        if ($pledge->status !== 'pending') {
            return response()->json(['message' => 'لا يمكن تعديل التعهد بعد الموافقة'], 400);
        }

        $validated = $request->validate([
            'item_name' => 'sometimes|string|max:255',
            'quantity'  => 'sometimes|integer|min:1',
            'notes'     => 'nullable|string',
        ]);

        $pledge->update($validated);

        return response()->json($pledge);
    }

     // حذف تعهد (بس إذا كان لسا pending)
    public function destroy($id)
    {
        $pledge = Pledge::findOrFail($id);

        if ($pledge->user_id !== Auth::id()) {
            return response()->json(['message' => 'غير مسموح'], 403);
        }

        if ($pledge->status !== 'pending') {
            return response()->json(['message' => 'لا يمكن حذف التعهد بعد الموافقة'], 400);
        }

        $pledge->delete();

        return response()->json(['message' => 'تم حذف التعهد']);
    }

    public function myPledges()
    {
        $pledges = Pledge::where('user_id', Auth::id())
            ->with('event')
            ->get();

        return response()->json($pledges);
    }


  public function updateStatus(Request $request, $id)
    {
        $pledge = Pledge::findOrFail($id);
        $event  = $pledge->event;

        // تحقق أن المستخدم الحالي هو صاحب الفعالية
        if ($event->creator_id !== Auth::id()) {
            return response()->json(['message' => 'غير مسموح'], 403);
        }

        $validated = $request->validate([
            'status' => 'required|in:pending,approved,rejected,delivered',
        ]);

        $pledge->status = $validated['status'];
        $pledge->save();

        return response()->json($pledge);
    }
}
