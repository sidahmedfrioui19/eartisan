class Picture {
  final int pictureId;
  final String link;

  Picture({
    required this.pictureId,
    required this.link,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      pictureId: json['picture_id'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'picture_id': pictureId,
      'link': link,
    };
  }
}
