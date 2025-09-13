class User {
  int? id;
  int? districtId;
  String? name;
  var associationName;
  String? birthDate;
  String? email;
  var emailVerifiedAt;
  String? phone;
  var address;
  String? status;
  int? totalHours;
  String? createdAt;
  String? updatedAt;
  var deletedAt;

  User({
    this.id,
    this.districtId,
    this.name,
    this.associationName,
    this.birthDate,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.address,
    this.status,
    this.totalHours,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['district_id'];
    name = json['name'];
    associationName = json['association_name'];
    birthDate = json['birth_date'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    address = json['address'];
    status = json['status'];
    totalHours = json['total_hours'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
}
