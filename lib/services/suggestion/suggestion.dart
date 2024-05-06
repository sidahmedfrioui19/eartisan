import 'dart:convert';
import 'package:profinder/models/suggestion/suggestion_creation_request.dart';
import 'package:profinder/services/data.dart';

class SuggestionService {
  final GenericDataService<SuggestionCreationRequest> _genericService =
      GenericDataService<SuggestionCreationRequest>('suggestion', {
    'post': 'add',
  });

  Future<Map<String, bool>> post(SuggestionCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }
}
