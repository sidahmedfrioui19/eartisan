import 'dart:convert';
import 'package:profinder/models/appointement/appointment_creation_request.dart';
import 'package:profinder/services/data.dart';

class AppointementService {
  final GenericDataService _genericService = GenericDataService('appointment', {
    'post': 'create',
  });

  Future<Map<String, bool>> post(AppointementCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }
}
