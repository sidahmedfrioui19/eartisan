import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/constants.dart';

class AuthenticationService {
  final url = Constants.apiUrl;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> login(String email, String password) async {
    final String path = 'login';
    final response = await http.post(
      Uri.parse('$url/$path'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String jwtToken = data['token'];

      await secureStorage.write(key: 'jwtToken', value: jwtToken);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'jwtToken');
  }

  Future<Future<http.StreamedResponse>> addAuthorizationHeader(
      http.Request request) async {
    final String jwtToken = await getJwtToken();

    if (jwtToken.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $jwtToken';
    }

    return http.Client().send(request);
  }

  static Future<String> getJwtToken() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? jwtToken = await secureStorage.read(key: 'jwtToken');
    return jwtToken ?? '';
  }

  Future<bool> checkAuth() async {
    return getJwtToken() != '' ? true : false;
  }

  static Future<http.Response> authorizedGet(String url) async {
    final String token = await AuthenticationService.getJwtToken();
    return http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  static Future<http.Response> authorizedPost(String url, dynamic data) async {
    final String token = await AuthenticationService.getJwtToken();
    return http.post(
      Uri.parse(url),
      body: data,
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  static Future<http.Response> authorizedPatch(String url) async {
    final String token = await AuthenticationService.getJwtToken();
    return http.patch(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
