<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\District;
use Illuminate\Http\Request;

class DistrictController extends Controller
{
      public function index($id)
    {
        $governorates = District::where('governorate_id',$id)->get();

        return response()->json([
            'status' => true,
            'data' => $governorates
        ]);
    }

    // إضافة حي
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'governorate_id' => 'required|exists:governorates,id',
        ]);

        $district = District::create([
            'name' => $request->name,
            'governorate_id' => $request->governorate_id,
        ]);

        return response()->json(['message' => 'District created successfully', 'data' => $district], 201);
    }

    // تعديل حي
    public function update(Request $request, District $district)
    {
        $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $district->update([
            'name' => $request->name,
        ]);

        return response()->json(['message' => 'District updated successfully', 'data' => $district]);
    }

    // حذف حي
    public function destroy(District $district)
    {
        $district->delete();

        return response()->json(['message' => 'District deleted successfully']);
    }
}
