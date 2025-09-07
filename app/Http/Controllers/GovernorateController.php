<?php

namespace App\Http\Controllers;

use App\Models\Governorate;
use Illuminate\Http\Request;

class GovernorateController extends Controller
{
    public function index()
    {
        $governorates = Governorate::with('districts')->get();

        return response()->json([
            'status' => true,
            'data' => $governorates
        ]);
    }
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255|unique:governorates,name',
        ]);

        $governorate = Governorate::create([
            'name' => $request->name,
        ]);

        return response()->json(['message' => 'Governorate created successfully', 'data' => $governorate], 201);
    }

    // تعديل محافظة
    public function update(Request $request, Governorate $governorate)
    {
        $request->validate([
            'name' => 'required|string|max:255|unique:governorates,name,' . $governorate->id,
        ]);

        $governorate->update(['name' => $request->name]);

        return response()->json(['message' => 'Governorate updated successfully', 'data' => $governorate]);
    }

    // حذف محافظة
    public function destroy(Governorate $governorate)
    {
        $governorate->delete();

        return response()->json(['message' => 'Governorate deleted successfully']);
    }
}
