class Reportable {
  int? id;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? location;
  String? category;
  int? maxVolunteers;
  int? creatorId;
  int? districtId;
  String? status;
  var rejectionReason;
  String? createdAt;
  String? updatedAt;
  var deletedAt;
  String? name;
  var associationName;
  String? birthDate;
  String? email;
  var emailVerifiedAt;
  String? phone;
  var address;
  int? totalHours;

  Reportable({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.location,
    this.category,
    this.maxVolunteers,
    this.creatorId,
    this.districtId,
    this.status,
    this.rejectionReason,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.associationName,
    this.birthDate,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.address,
    this.totalHours,
  });

  Reportable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    location = json['location'];
    category = json['category'];
    maxVolunteers = json['max_volunteers'];
    creatorId = json['creator_id'];
    districtId = json['district_id'];
    status = json['status'];
    rejectionReason = json['rejection_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    name = json['name'];
    associationName = json['association_name'];
    birthDate = json['birth_date'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    address = json['address'];
    totalHours = json['total_hours'];
  }
}
