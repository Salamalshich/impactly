<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Role;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        // 1. التحقق من صحة البيانات المدخلة
        $rules = [
        'name' => 'required|string|max:255',
        'email' => 'required|string|email|max:255|unique:users',
        'password' => 'required|string|min:8',
        'phone' => 'required|string|max:20',
        'role_id' => 'required|integer|exists:roles,id',
        'address' => 'nullable|string|max:255',
        'association_name' => 'nullable|string|max:255',
        'birth_date' => 'nullable|date',
        'district_id' => 'nullable|integer|exists:districts,id',
        ];

        // تعديل القواعد حسب الدور
        if ($request->role_id == 1) {
            $rules['association_name'] = 'required|string|max:255';
            $rules['address'] = 'required|string|max:255';
        } elseif ($request->role_id == 2) {
            $rules['birth_date'] = 'required|date';
            $rules['district_id'] = 'required|integer|exists:districts,id';
        }

        // التحقق من البيانات
        $validated = $request->validate($rules);

        DB::beginTransaction();
        try {
            // إنشاء المستخدم
            $user = User::create([
                'name' => $validated['name'],
                'email' => $validated['email'],
                'password' => Hash::make($validated['password']),
                'phone' => $validated['phone'],
                'birth_date' => $validated['birth_date'] ?? null,
                'district_id' => $validated['district_id'] ?? null,
                'association_name' => $validated['association_name'] ?? null,
                'address' => $validated['address'] ?? null,
            ]);

            // ربط الدور
            $user->roles()->attach($validated['role_id']);

            // تأكيد العمليات في قاعدة البيانات
            DB::commit();

            // 4. إنشاء التوكن وإرجاع الاستجابة
            return response()->json([
                'message' => 'User registered successfully!',
                'token' => $user->createToken('auth_token')->plainTextToken,
                'user' => $user, // إرجاع بيانات المستخدم للتأكيد
            ], 201);

        } catch (\Exception $e) {
            // في حال حدوث أي خطأ، يتم التراجع عن كل العمليات
            DB::rollBack();

            // إرجاع رسالة خطأ
            return response()->json([
                'message' => 'Registration failed!',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function login(Request $request)
    {
        // 1. التحقق من صحة المدخلات
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        // 2. البحث عن المستخدم والتحقق من كلمة المرور
        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            // إرجاع استجابة خطأ واضحة إذا كانت البيانات غير صحيحة
            return response()->json([
                'message' => 'The provided credentials are incorrect.'
            ], 401); // 401 Unauthorized
        }

        // 3. تحميل الأدوار المرتبطة بالمستخدم
        // Eager Loading: نستخدم load() لتحميل علاقة 'roles' بكفاءة
        $user->load('roles');

        // 4. استخلاص أسماء الأدوار فقط من العلاقة
        // pluck('name') تأخذ كل كائنات الأدوار وتستخرج قيمة 'name' منها فقط
        $roles = $user->roles->pluck('name');

        // 5. إنشاء التوكن وإرجاع الاستجابة المطلوبة
        return response()->json([
            'token' => $user->createToken('auth_token')->plainTextToken,
            'roles' => $roles, // إرجاع مصفوفة بأسماء الأدوار
        ]);
    }

}
