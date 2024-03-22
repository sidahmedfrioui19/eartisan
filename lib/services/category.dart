import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class CategoryService {
  final String path;

  CategoryService({required this.path});

  Future<dynamic> fetchData(String path) async {
    final url = Constants.apiUrl;
    final response = await http.get(Uri.parse('$url/$path'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
