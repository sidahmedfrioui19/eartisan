class Message {
  final int messageId;
  final String content;
  final int senderId;
  final int receiverId;
  final int conversationId;
  final DateTime createdAt;

  Message({
    required this.messageId,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['message_id'],
      content: json['content'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      conversationId: json['conversation_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'content': content,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'conversation_id': conversationId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
