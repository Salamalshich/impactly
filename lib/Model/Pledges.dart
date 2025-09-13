import 'package:impactlyflutter/Model/Event.dart';
import 'package:impactlyflutter/Model/User.dart';

class Pledges {
  int? id;
  int? userId;
  int? eventId;

  String? pledgeType;

  int? requestedId;

  String? itemName;
  int? quantity;

  String? status;

  String? notes;

  String? donationType;

  double? amount;

  String? createdAt;
  String? updatedAt;
  Event? event;
  User? user;

  Pledges({
    this.id,
    this.userId,
    this.eventId,
    this.pledgeType,
    this.requestedId,
    this.itemName,
    this.quantity,
    this.status,
    this.notes,
    this.donationType,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.event,
    this.user,
  });

  Pledges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    eventId = json['event_id'];
    pledgeType = json['pledge_type'];
    requestedId = json['requested_id'];
    itemName = json['item_name'];
    quantity = json['quantity'];
    status = json['status'];
    notes = json['notes'];
    donationType = json['donation_type'];
    amount =
        json['amount'] != null
            ? double.tryParse(json['amount'].toString())
            : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['event'] != null) {
      event = Event.fromJsonPledge(json['event']);
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}
