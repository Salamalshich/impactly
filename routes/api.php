<?php

use App\Http\Controllers\DistrictController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\EventController;
use App\Http\Controllers\GovernorateController;
use App\Http\Controllers\PledgeController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\VolunteerEventController;
use App\Http\Middleware\RoleMiddleware;
use Illuminate\Support\Facades\Route;



// (مسارات انشاء الحساب وتسجيل الدخول)
Route::post('/login', [AuthController::class, 'login']);//

Route::post('/register', [AuthController::class, 'register']);//

// المحافظات
Route::get('/governorates', [GovernorateController::class, 'index']);//



Route::middleware('auth:sanctum')->group(function () {

    // مسار يمكن الوصول إليه فقط من قبل المنظمات (Organizers)
    Route::middleware(RoleMiddleware::class.':Organizer')->group(function () {

    });

    // مسار يمكن الوصول إليه فقط من قبل المتطوعين أو المنظمين (User)
    Route::middleware(RoleMiddleware::class.':User')->group(function () {
        Route::get('/district-events', [EventController::class, 'eventsByDistrict']);//
        // تسجيل متطوع في فعالية
        Route::post('/events/{eventId}/register', [VolunteerEventController::class, 'register']);//
        // الانسحاب / إلغاء التسجيل من قبل المستخدم
        Route::delete('/volunteer-registrations/{id}/withdraw', [VolunteerEventController::class, 'withdraw']);//
        // تحديث feedback أو rating بعد الحضور
        Route::put('/volunteer-registrations/{id}/feedback', [VolunteerEventController::class, 'updateFeedback']);//
        // الفعاليات اللي المستخدم مسجل فيها
        Route::get('/my-registered-events', [EventController::class, 'myRegisteredEvents']);//

        Route::post('/scan-qr', [VolunteerEventController::class, 'scanQr']);//

    });

    Route::middleware(RoleMiddleware::class.':User,Organizer')->group(function () {
        //Profile
        Route::get('/profile', [ProfileController::class, 'getProfile']);
        Route::put('/profile', [ProfileController::class, 'updateProfile']);
        //
        Route::post('/events', [EventController::class, 'store']);//
        Route::get('/events/{id}', [EventController::class, 'show']);
        Route::put('/events/{id}', [EventController::class, 'update']);//
        Route::delete('/events/{id}', [EventController::class, 'destroy']);//
        Route::get('/my-events', [EventController::class, 'myEvents']);//
        //////
        Route::post('/verify-hours/{participationId}', [VolunteerEventController::class, 'verifyHours']);//
        Route::post('/volunteer-no-show/{participationId}', [VolunteerEventController::class, 'volunteerNoShow']);//
        Route::post('/completeEvent/{eventId}', [VolunteerEventController::class, 'completeEvent']);//
        //////
        Route::post('/pledges', [PledgeController::class, 'store']); //
        Route::put('/pledges/{id}', [PledgeController::class, 'update']);//
        Route::delete('/pledges/{id}', [PledgeController::class, 'destroy']); //
        Route::get('/my-pledges', [PledgeController::class, 'myPledges']); //
        //////
        Route::post('/pledges/{id}/status', [PledgeController::class, 'updateStatus']);
    });


    // مسار يمكن الوصول إليه فقط من قبل المدراء (Admins)
    Route::middleware(RoleMiddleware::class.':Admin')->group(function () {
        // المحافظات
        Route::post('/admin/governorates', [GovernorateController::class, 'store']);//
        Route::put('/admin/governorates/{governorate}', [GovernorateController::class, 'update']);//
        Route::delete('/admin/governorates/{governorate}', [GovernorateController::class, 'destroy']);//

        // الأحياء
        Route::get('/admin/districts/{id}', [DistrictController::class, 'index']);//
        Route::post('/admin/districts', [DistrictController::class, 'store']);//
        Route::put('/admin/districts/{district}', [DistrictController::class, 'update']);//
        Route::delete('/admin/districts/{district}', [DistrictController::class, 'destroy']);//
        //
        Route::get('/events', [EventController::class, 'index']);
        Route::put('/admin/events/{id}/status', [EventController::class, 'updateStatus']);
    });
});
