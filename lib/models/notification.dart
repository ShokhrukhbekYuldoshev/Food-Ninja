class Notification {
  final String title;
  final bool isSuccess;
  final DateTime createdAt;

  Notification({
    required this.title,
    required this.isSuccess,
    required this.createdAt,
  });

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      title: map['title'],
      isSuccess: map['isSuccess'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isSuccess': isSuccess,
      'createdAt': createdAt,
    };
  }
}
