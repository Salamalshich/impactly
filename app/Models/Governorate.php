<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Governorate extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
    ];

    /**
     * العلاقة: المحافظة إلها عدة أحياء
     */
    public function districts()
    {
        return $this->hasMany(District::class);
    }
}
