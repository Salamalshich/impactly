class Wallet {
  int? id;
  int? userId;
  String? balance;
  String? createdAt;
  String? updatedAt;

  Wallet({this.id, this.userId, this.balance, this.createdAt, this.updatedAt});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    balance = json['balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
