<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VolunteerEventParticipation extends Model
{
    use HasFactory;

    protected $table = 'volunteer_event_participation';

    protected $fillable = [
        'user_id',
        'event_id',
        'check_in',
        'check_out',
        'verified_by',
        'hours_worked',
        'approved',
        'approved_by',
        'status',
        'feedback',
        'rating',
    ];

    protected $casts = [
        'check_in' => 'datetime',
        'check_out' => 'datetime',
        'approved' => 'boolean',
    ];

    // علاقات
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function event()
    {
        return $this->belongsTo(Event::class);
    }

    public function verifier()
    {
        return $this->belongsTo(User::class, 'verified_by');
    }

    public function approver()
    {
        return $this->belongsTo(User::class, 'approved_by');
    }
}
