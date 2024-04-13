import 'dart:convert';

import 'package:profinder/models/review/review_creation_request.dart';
import 'package:profinder/services/data.dart';

class ReviewService {
  final GenericDataService _genericService = GenericDataService('review', {
    'get': 'view',
    'post': 'add',
  });

  Future<Map<String, bool>> post(ReviewCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }
}
