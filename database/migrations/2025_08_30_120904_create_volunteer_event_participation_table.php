<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('volunteer_event_participation', function (Blueprint $table) {
            $table->id();

            // علاقات المستخدم والفعالية
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->foreignId('event_id')->constrained()->onDelete('cascade');

            // بيانات الحضور
            $table->timestamp('check_in')->nullable();
            $table->timestamp('check_out')->nullable();
            $table->foreignId('verified_by')->nullable()->constrained('users');

            // بيانات الساعات
            $table->integer('hours_worked')->nullable();
            $table->boolean('approved')->default(false); // اعتماد المنظم
            $table->foreignId('approved_by')->nullable()->constrained('users'); // المنظم

            // حالة التسجيل
            $table->enum('status', ['registered', 'attended', 'cancelled', 'no_show'])->default('registered');
            $table->text('feedback')->nullable();
            $table->integer('rating')->nullable();

            $table->timestamps();

            // ضمان فريد لكل مستخدم × فعالية
            $table->unique(['user_id', 'event_id']);
        });
    }

    public function down()
    {
        Schema::dropIfExists('volunteer_event_participation');
    }
};
