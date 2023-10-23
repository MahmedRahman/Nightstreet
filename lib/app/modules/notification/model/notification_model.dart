class NotificationModel {
  final String title;
  final String? body;
  final String? icon;
  final String? createdAt;
  final num? isRead;

  NotificationModel({
    required this.title,
    this.body,
    this.icon,
    this.createdAt,
    this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      icon: json['icon'],
      createdAt: json['created_at'],
      isRead: json['is_read'],
    );
  }
}
