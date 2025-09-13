class Category {
  int? id;
  String? nameEn;
  String? nameAr;
  String? name;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.nameAr,
    this.nameEn,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
