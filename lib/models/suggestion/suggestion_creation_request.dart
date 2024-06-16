class SuggestionCreationRequest {
  final String description;

  SuggestionCreationRequest({
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
    };
  }
}
