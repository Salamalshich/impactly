class Transactions {
  int? id;
  int? fromUserId;
  int? toUserId;
  String? amount;
  String? type;
  String? status;
  var method;
  var notes;
  String? createdAt;
  String? updatedAt;

  Transactions({
    this.id,
    this.fromUserId,
    this.toUserId,
    this.amount,
    this.type,
    this.status,
    this.method,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUserId = json['from_user_id'];
    toUserId = json['to_user_id'];
    amount = json['amount'];
    type = json['type'];
    status = json['status'];
    method = json['method'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
