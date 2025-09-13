import 'package:impactlyflutter/Model/Event.dart';
import 'package:impactlyflutter/Model/User.dart';

class Pledges {
  int? id;
  int? userId;
  int? eventId;
<<<<<<< HEAD

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
=======
  String? itemName;
  int? quantity;
  String? status;
  String? notes;
  var createdAt;
  var updatedAt;
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
  Event? event;
  User? user;

  Pledges({
    this.id,
    this.userId,
    this.eventId,
<<<<<<< HEAD
    this.pledgeType,
    this.requestedId,
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    this.itemName,
    this.quantity,
    this.status,
    this.notes,
<<<<<<< HEAD
    this.donationType,
    this.amount,
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    this.createdAt,
    this.updatedAt,
    this.event,
    this.user,
  });

  Pledges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    eventId = json['event_id'];
<<<<<<< HEAD
    pledgeType = json['pledge_type'];
    requestedId = json['requested_id'];
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    itemName = json['item_name'];
    quantity = json['quantity'];
    status = json['status'];
    notes = json['notes'];
<<<<<<< HEAD
    donationType = json['donation_type'];
    amount =
        json['amount'] != null
            ? double.tryParse(json['amount'].toString())
            : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['event'] != null) {
      event = Event.fromJsonPledge(json['event']);
=======
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['event'] != null) {
      event = Event.fromJson(json['event']);
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}
