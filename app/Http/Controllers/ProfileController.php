<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ProfileController extends Controller
{
    public function getProfile()
    {
        $user = Auth::user()->load('district.governorate');

        return response()->json($user);
    }

    // تعديل البروفايل
    public function updateProfile(Request $request)
    {
        $user = Auth::user();

        $validated = $request->validate([
            'name'             => 'sometimes|string|max:255',
            'association_name' => 'sometimes|nullable|string|max:255',
            'birth_date'       => 'sometimes|nullable|date',
            'phone'            => 'sometimes|nullable|string|max:20',
            'address'          => 'sometimes|nullable|string',
            'district_id'      => 'sometimes|nullable|exists:districts,id',
        ]);

        $user->update($validated);

        return response()->json($user->load(['roles', 'district']));
    }
}
