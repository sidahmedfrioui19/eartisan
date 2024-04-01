import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:profinder/services/authentication.dart';
import 'package:profinder/utils/constants.dart';

class GenericDataService<T> {
  final url = Constants.apiUrl;
  final serviceEntityName;
  final Map<String, String> endpoints;

  GenericDataService(this.serviceEntityName, this.endpoints);

  Future<List<T>> fetch(T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse(_urlBuilder('get')));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final List<T> items = (parsed['data'] as List<dynamic>).map((itemJson) {
        return fromJson(itemJson);
      }).toList();
      return items;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<T> post(String body) async {
    final String? jwtToken = await AuthenticationService.getJwtToken();
    final response = await http.post(
      Uri.parse(_urlBuilder('post')),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type':
            'application/json', // Example of adding a Content-Type header
        // Add more headers as needed
      },
      body: body,
    );
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed;
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<T> patch(String body) async {
    final String? jwtToken = await AuthenticationService.getJwtToken();
    final response = await http.patch(
      Uri.parse(_urlBuilder('patch')),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type':
            'application/json', // Example of adding a Content-Type header
        // Add more headers as needed
      },
      body: body,
    );
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed;
    } else {
      throw Exception('Failed to patch data');
    }
  }

  String _urlBuilder(String method) {
    String? endpoint = endpoints[method];
    return '$url/$serviceEntityName/$endpoint';
  }
}
