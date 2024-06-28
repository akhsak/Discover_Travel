class NotificationModel {
  String? id;
  String? recieverId;
  String? title;
  String? body;
  bool? read;
  NotificationModel(
      {this.id, this.recieverId, this.title, this.body, this.read = false});

  factory NotificationModel.fromJson(String id, Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      recieverId: json['recieverId'],
      title: json['title'],
      body: json['body'],
      read: json['read'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recieverId': recieverId,
      'title': title,
      'body': body,
      'read': read,
    };
  }
}
