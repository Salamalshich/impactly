<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasFactory, Notifiable, SoftDeletes, HasApiTokens;

    protected $fillable = [
        'name',
        'email',
        'password',
        'phone',
        'address',
        'status',
        'total_hours',
        'birth_date',
        'district_id',
        'association_name'
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    protected $attributes = [
        'status' => 'active',
        'total_hours' => 0,
    ];

    // Roles
    public function roles()
    {
        return $this->belongsToMany(Role::class);
    }

    public function hasRole(string $roleName): bool
    {
        return $this->roles()->where('name', $roleName)->exists();
    }

    public function hasAnyRole(array $roleNames): bool
    {
        return $this->roles()->whereIn('name', $roleNames)->exists();
    }

    // Events created by user
    public function createdEvents()
    {
        return $this->hasMany(Event::class, 'creator_id');
    }

    // Volunteer Event Participation
    public function volunteerParticipations()
    {
        return $this->hasMany(VolunteerEventParticipation::class);
    }

    // Verified participations by user (as organizer)
    public function verifiedParticipations()
    {
        return $this->hasMany(VolunteerEventParticipation::class, 'verified_by');
    }

    // Approved participations by user (as organizer)
    public function approvedParticipations()
    {
        return $this->hasMany(VolunteerEventParticipation::class, 'approved_by');
    }

    public function district()
    {
        return $this->belongsTo(District::class);
    }

    public function pledges()
    {
        return $this->hasMany(Pledge::class);
    }

    public function reports()
    {
        return $this->hasMany(Report::class, 'reporter_id');
    }

    public function resolvedReports()
    {
        return $this->hasMany(Report::class, 'resolved_by');
    }
}
