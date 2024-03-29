class ResponseMessage {
  final String message;
  final bool success;

  ResponseMessage({
    required this.message,
    required this.success,
  });

  factory ResponseMessage.fromJson(Map<String, dynamic> json) {
    return ResponseMessage(
      message: json['message'],
      success: json['success'],
    );
  }
}
