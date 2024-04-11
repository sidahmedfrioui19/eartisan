import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/models/generic_search/generic_search_request.dart';
import 'package:profinder/models/generic_search/generic_search_response.dart';
import 'package:profinder/utils/constants.dart';
import 'package:http/http.dart' as http;

class GenericSearch {
  final apiUrl = Constants.apiUrl;

  Future<GenericSearchResponse> post(GenericSearchRequest entity) async {
    try {
      final FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final String? jwtToken = await secureStorage.read(key: 'jwtToken');
      final uri = Uri.parse('$apiUrl/search/');
      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $jwtToken'
      };

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(entity),
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final GenericSearchResponse items = parsed['data'].map((itemJson) {
          return GenericSearchResponse.fromJson(itemJson);
        }).toList();

        return items;
      } else {
        throw Exception('Failed to send message: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending message: $error');
      throw Exception('Failed to send message: $error');
    }
  }
}
