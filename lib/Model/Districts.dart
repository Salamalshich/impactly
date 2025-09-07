import 'package:impactlyflutter/Model/Governorate.dart';

class District {
  int? id;
  int? governorateId;
  String? name;
  String? createdAt;
  String? updatedAt;
  Governorate? governorate;

  District({
    this.id,
    this.governorateId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.governorate,
  });

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorateId = json['governorate_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    governorate =
        json['governorate'] != null
            ? Governorate.fromJson(json['governorate'])
            : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['governorate_id'] = governorateId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (governorate != null) {
      data['governorate'] = governorate!.toJson();
    }
    return data;
  }
}
