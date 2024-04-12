class NotificationCreationRequest {
  final String? content;
  final int? receivingUser;

  NotificationCreationRequest({
    required this.content,
    required this.receivingUser,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'receive_user_id': receivingUser,
    };
  }
}
