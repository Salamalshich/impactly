import 'package:impactlyflutter/Model/User.dart';

class Attendances {
  int? id;
  int? userId;
  int? eventId;
  var checkIn;
  var checkOut;
  var verifiedBy;
  String? createdAt;
  String? updatedAt;
  User? user;

  Attendances({
    this.id,
    this.userId,
    this.eventId,
    this.checkIn,
    this.checkOut,
    this.verifiedBy,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Attendances.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    eventId = json['event_id'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    verifiedBy = json['verified_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}
