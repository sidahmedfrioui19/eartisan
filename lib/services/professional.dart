import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:profinder/models/service.dart';

import '../utils/constants.dart';

class ProfessionalService {
  final String path = 'service/viewall';

  Future<List<ServiceEntity>> fetchServices() async {
    final url = Constants.apiUrl;
    final response = await http.get(Uri.parse('$url/$path'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      print(jsonEncode(parsed));

      final List<ServiceEntity> services =
          (parsed['data'] as List<dynamic>).map((serviceJson) {
        return ServiceEntity.fromJson(serviceJson);
      }).toList();
      return services;
    } else {
      throw Exception('Failed to load services');
    }
  }
}
