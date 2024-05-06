class ReportEntity {
  final String description;
  final int? reported_id;

  ReportEntity({
    required this.description,
    this.reported_id,
  });

  factory ReportEntity.fromJson(Map<String, dynamic> json) {
    return ReportEntity(
      description: json['description'] ?? '',
      reported_id: json['reported_id'] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'reported_id': reported_id,
    };
  }
}
