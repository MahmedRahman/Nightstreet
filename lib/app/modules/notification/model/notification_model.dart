class NotificationModel {
  final int id;

  final String title;
  final String? body;
  final String? icon;
  final String? createdAt;
  final String? clickAction;
  final int? redirectId;

  final num? isRead;

  NotificationModel(
      {required this.title,
      required this.id,
      this.body,
      this.icon,
      this.createdAt,
      this.isRead,
      this.clickAction,
      this.redirectId});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      icon: json['icon'],
      createdAt: json['created_at'],
      isRead: json['is_read'],
      clickAction: json['click_action'],
      redirectId: json['redirect_id'],
    );
  }
}
