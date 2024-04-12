import 'dart:convert';
import 'package:profinder/models/appointement/appointment_creation_request.dart';
import 'package:profinder/services/data.dart';
import 'package:http/http.dart' as http;
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/utils/error_handler/business_error_handler.dart';
import 'package:profinder/utils/error_handler/error_payload.dart';

class AppointementService {
  final apiUrl = Constants.apiUrl;
  final GenericDataService _genericService = GenericDataService('appointment', {
    'post': 'create',
  });

  Future<Map<String, bool>> post(AppointementCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }

  Future<Map<String, bool>> setStatus(Map<String, String> body, int id) async {
    final String? jwtToken = await AuthenticationService.getJwtToken();
    print('$apiUrl/appointment/update/$id');
    final response = await http.patch(
      Uri.parse('$apiUrl/post/update/$id'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      ErrorPayload? errorPayload = await BusinessErrorHandler.checkErrorType();
      BusinessErrorHandler.handleError(errorPayload);

      throw Exception('Request failed with status ${response.statusCode}');
    }
  }
}
