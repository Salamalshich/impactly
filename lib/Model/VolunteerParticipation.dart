import 'package:impactlyflutter/Model/User.dart';

class VolunteerParticipation {
  int? id;
  int? userId;
  int? eventId;
  DateTime? checkIn; // وقت الدخول
  DateTime? checkOut; // وقت الخروج
  int? verifiedBy; // معرف المنظم يلي تحقق الحضور
  int? hoursWorked; // الساعات اللي سجلها أو عدلها المنظم
  bool? approved; // true → المنظم تحقق منها
  int? approvedBy; // معرف المنظم يلي تحقق الساعات
  String? status; // registered, attended, cancelled, no_show
  String? feedback;
  int? rating;
  User? user; // معلومات المستخدم

  VolunteerParticipation({
    this.id,
    this.userId,
    this.eventId,
    this.checkIn,
    this.checkOut,
    this.verifiedBy,
    this.hoursWorked,
    this.approved,
    this.approvedBy,
    this.status,
    this.feedback,
    this.rating,
    this.user,
  });

  factory VolunteerParticipation.fromJson(Map<String, dynamic> json) {
    return VolunteerParticipation(
      id: json['id'],
      userId: json['user_id'],
      eventId: json['event_id'],
      checkIn:
          json['check_in'] != null ? DateTime.parse(json['check_in']) : null,
      checkOut:
          json['check_out'] != null ? DateTime.parse(json['check_out']) : null,
      verifiedBy: json['verified_by'],
      hoursWorked: json['hours_worked'],
      approved: json['approved'] ?? false,
      approvedBy: json['approved_by'],
      status: json['status'],
      feedback: json['feedback'],
      rating: json['rating'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
