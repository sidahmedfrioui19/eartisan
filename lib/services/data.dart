import 'dart:convert';
import 'package:http/http.dart' as http;
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
      print(jsonEncode(parsed));

      final List<T> items = (parsed['data'] as List<dynamic>).map((itemJson) {
        return fromJson(itemJson);
      }).toList();
      return items;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<T> post(String body, T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.post(
      Uri.parse(_urlBuilder('post')),
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return fromJson(parsed);
    } else {
      throw Exception('Failed to post data');
    }
  }

  String _urlBuilder(String method) {
    String? endpoint = endpoints[method];
    return '$url/$serviceEntityName/$endpoint';
  }
}
