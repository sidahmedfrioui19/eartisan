import 'dart:convert';
import 'package:profinder/models/appointement/appointment_creation_request.dart';
import 'package:profinder/models/appointement/appointment_update_request.dart';
import 'package:profinder/services/data.dart';
import 'package:http/http.dart' as http;
import 'package:profinder/services/notification/notification.dart';
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
    final NotificationService notification = NotificationService();

    await notification.notifyUser(entity.professionalId,
        'You have a new appointment request, check your appointments section for more details.');
    return _genericService.post(body);
  }

  Future<Map<String, bool>> cancel(Map<String, String> body, int? id) async {
    final String? jwtToken = await AuthenticationService.getJwtToken();
    final response = await http.patch(
      Uri.parse('$apiUrl/post/update/$id'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      body: {
        '_status': 'cancelled',
      },
    );

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      ErrorPayload? errorPayload = await BusinessErrorHandler.checkErrorType();
      BusinessErrorHandler.handleError(errorPayload);

      throw Exception('Request failed with status ${response.statusCode}');
    }
  }

  Future<Map<String, bool>> update(
      AppointementUpdateRequest entity, int? id, String userId) async {
    final String? jwtToken = await AuthenticationService.getJwtToken();
    final response = await http.patch(
      Uri.parse('$apiUrl/appointment/update/$id'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      body: entity.toJson(),
    );

    if (response.statusCode == 200) {
      final NotificationService notification = NotificationService();

      await notification.notifyUser(userId,
          'Your appointement has been updated check your appointements section for more details.');

      return {'success': true};
    } else {
      ErrorPayload? errorPayload = await BusinessErrorHandler.checkErrorType();
      BusinessErrorHandler.handleError(errorPayload);

      throw Exception('Request failed with status ${response.statusCode}');
    }
  }
}
