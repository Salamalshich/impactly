import 'package:impactlyflutter/Model/Event.dart';
import 'package:impactlyflutter/Model/User.dart';

class Pledges {
  int? id;
  int? userId;
  int? eventId;
  String? itemName;
  int? quantity;
  String? status;
  String? notes;
  var createdAt;
  var updatedAt;
  Event? event;
  User? user;

  Pledges({
    this.id,
    this.userId,
    this.eventId,
    this.itemName,
    this.quantity,
    this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.event,
    this.user,
  });

  Pledges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    eventId = json['event_id'];
    itemName = json['item_name'];
    quantity = json['quantity'];
    status = json['status'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['event'] != null) {
      event = Event.fromJson(json['event']);
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}
