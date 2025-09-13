import 'package:impactlyflutter/Model/Districts.dart';

class Governorate {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<District>? districts;

  Governorate({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.districts,
  });

  Governorate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['districts'] != null) {
      districts = <District>[];
      json['districts'].forEach((v) {
        districts!.add(District.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
