class AppNotificationItem {
  const AppNotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isUnread = true,
  });

  final String id;
  final String title;
  final String message;
  final String time;
  final String type;
  final bool isUnread;
}
