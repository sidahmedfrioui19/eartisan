class PriceCreationRequest {
  final int service_id;
  final String value;
  final String description;
  final String rate;

  PriceCreationRequest({
    required this.service_id,
    required this.description,
    required this.rate,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      "value": value,
      "description": description,
      "rate": rate,
      "service_id": service_id
    };
  }
}
