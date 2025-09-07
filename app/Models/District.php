<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class District extends Model
{
    use HasFactory;

    protected $fillable = [
        'governorate_id',
        'name',
    ];

    /**
     * العلاقة: الحي تابع لمحافظة وحدة
     */
    public function governorate()
    {
        return $this->belongsTo(Governorate::class);
    }
}
