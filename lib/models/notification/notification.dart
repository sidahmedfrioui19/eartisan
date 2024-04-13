class NotificationEntity {
  final int? notificationId;
  final String? content;
  final int userId;
  final User user;

  NotificationEntity({
    required this.notificationId,
    required this.content,
    required this.userId,
    required this.user,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      notificationId: json['notification_id'],
      content: json['content'],
      userId: json['user_id'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int? userId;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? email;

  User({
    required this.userId,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
    );
  }
}
