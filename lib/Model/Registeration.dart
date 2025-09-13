class Registration {
  int? id;
  String? status;
  var hoursWorked;
  var feedback;
  var rating;
  String? createdAt;
  String? updatedAt;

  Registration({
    this.id,
    this.status,
    this.hoursWorked,
    this.feedback,
    this.rating,
    this.createdAt,
    this.updatedAt,
  });

  Registration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    hoursWorked = json['hours_worked'];
    feedback = json['feedback'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
