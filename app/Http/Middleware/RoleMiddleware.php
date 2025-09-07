<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class RoleMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string  ...$roles  // استخدام "..." لاستقبال كل الأدوار كعناصر متعددة
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function handle(Request $request, Closure $next, ...$roles): Response
    {
        // 1. التأكد من أن المستخدم مسجل دخوله
        // إذا لم يكن المستخدم مسجلاً، سيتم إيقافه بواسطة middleware 'auth:sanctum' قبل الوصول إلى هنا.
        // لكن من الجيد دائماً التحقق.
        if (!Auth::check()) {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }

        // 2. الحصول على المستخدم الحالي
        $user = Auth::user();

        // 3. التحقق مما إذا كان المستخدم يمتلك أياً من الأدوار المطلوبة
        // الدالة hasAnyRole تتحقق مما إذا كان المستخدم يمتلك *على الأقل واحد* من الأدوار المحددة.
        // هذا يحل مشكلة المستخدم الذي يمتلك أدواراً متعددة.
        if (!$user->hasAnyRole($roles)) {
            // إذا لم يكن لدى المستخدم أي من الأدوار المطلوبة، أرجع رسالة خطأ "غير مصرح به".
            return response()->json([
                'message' => 'This action is unauthorized. You do not have the required role.'
            ], 403); // 403 Forbidden هو كود الحالة الأنسب هنا
        }

        // 4. إذا كان المستخدم يمتلك الدور المطلوب، اسمح للطلب بالمرور
        return $next($request);
    }
}
