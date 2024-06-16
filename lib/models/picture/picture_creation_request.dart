class PictureCreationRequest {
  final String link;
  final int service_id;

  PictureCreationRequest({
    required this.link,
    required this.service_id,
  });

  Map<String, dynamic> toJson() {
    return {
      'link': link,
      'service_id': service_id,
    };
  }
}
