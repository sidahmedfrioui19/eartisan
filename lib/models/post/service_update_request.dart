class ServiceUpdateRequest {
  final String title;
  final String description;

  ServiceUpdateRequest({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
