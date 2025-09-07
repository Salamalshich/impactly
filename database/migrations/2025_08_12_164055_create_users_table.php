<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();

            // الحي مرتبط بجدول الأحياء
            $table->foreignId('district_id')
                  ->nullable()
                  ->constrained('districts')
                  ->nullOnDelete(); // لو انحذف الحي يصير null وما ينحذف المستخدم

            $table->string('name');
            $table->string('association_name')->nullable(); // اسم الجمعية
            $table->date('birth_date')->nullable();         // تاريخ الميلاد

            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->string('phone')->nullable();
            $table->text('address')->nullable();
            $table->enum('status', ['active', 'suspended', 'banned'])->default('active');
            $table->integer('total_hours')->default(0);
            $table->rememberToken();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
