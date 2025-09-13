class Notification {
  int? id;
  int? userId;
  String? title;
  String? body;
  int? isRead;
  String? createdAt;
  String? updatedAt;

  Notification({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    body = json['body'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
