import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:profinder/models/notification/notification.dart';
import 'package:profinder/models/notification/notification_creation_request.dart';
import 'package:profinder/services/data.dart';
import 'package:http/http.dart' as http;
import 'package:profinder/utils/constants.dart';
import 'package:profinder/utils/error_handler/business_error_handler.dart';
import 'package:profinder/utils/error_handler/error_payload.dart';

class NotificationService {
  final url = Constants.apiUrl;
  final GenericDataService _genericService =
      GenericDataService('notification', {
    'post': 'add',
  });

  Future<Map<String, bool>> post(NotificationCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }

  Future<Map<String, bool>> notifyUser(String userId, String message) async {
    try {
      DateTime now = DateTime.now();

      String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      final NotificationCreationRequest req = NotificationCreationRequest(
        content: '$formattedDate $message',
        receivingUser: userId,
      );

      await post(req);

      return {
        'success': true,
      };
    } catch (e) {
      ErrorPayload? errorPayload = await BusinessErrorHandler.checkErrorType();
      BusinessErrorHandler.handleError(errorPayload);

      throw Exception('Request failed');
    }
  }

  Future<List<NotificationEntity>> fetch() async {
    try {
      final FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? jwtToken = await secureStorage.read(key: 'jwtToken');
      final uri = Uri.parse('$url/notification/view');
      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $jwtToken'
      };

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final jsonData = parsed['data'];
        print(jsonData);

        final List<NotificationEntity> messages = [];
        for (var item in jsonData) {
          final message = NotificationEntity.fromJson(item);
          messages.add(message);
        }
        print(jsonEncode(messages));
        return messages;
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (error) {
      print('$error');
      throw Exception('$error');
    }
  }
}
