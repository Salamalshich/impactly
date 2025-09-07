<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Event extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'title',
        'description',
        'start_date',
        'end_date',
        'location',
        'category',
        'max_volunteers',
        'creator_id',
        'district_id',
        'status',
        'rejection_reason',
    ];

    protected $attributes = [
        'status' => 'pending',
    ];

    protected $casts = [
        'start_date' => 'datetime',
        'end_date'   => 'datetime',
    ];

    // Relationships
    public function creator()
    {
        return $this->belongsTo(User::class, 'creator_id');
    }

    public function district()
    {
        return $this->belongsTo(District::class);
    }

    // كل مشاركات المتطوعين بالفعالية
    public function volunteerParticipations()
    {
        return $this->hasMany(VolunteerEventParticipation::class);
    }

    // المشاركات اللي تحقق فيها المنظم
    public function verifiedParticipations()
    {
        return $this->hasMany(VolunteerEventParticipation::class, 'verified_by');
    }

    // المشاركات اللي اعتمدها المنظم
    public function approvedParticipations()
    {
        return $this->hasMany(VolunteerEventParticipation::class, 'approved_by');
    }

    public function pledges()
    {
        return $this->hasMany(Pledge::class);
    }

    public function reports()
    {
        return $this->morphMany(Report::class, 'reportable');
    }
}
