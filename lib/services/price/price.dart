import 'dart:convert';

import 'package:profinder/models/post/price_creation_request.dart';
import 'package:profinder/services/data.dart';
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/constants.dart';
import 'package:http/http.dart' as http;

class PriceService {
  final apiUrl = Constants.apiUrl;
  final GenericDataService<PriceCreationRequest> _genericService =
      GenericDataService<PriceCreationRequest>('price', {
    'post': 'add',
  });

  Future<Map<String, bool>> post(PriceCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }

  Future<Map<String, bool>> deleteById(int priceId) async {
    final url = Uri.parse('$apiUrl/price/delete/$priceId');
    final String jwtToken = await AuthenticationService.getJwtToken();
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        throw Exception('Failed to delete favorite with ID: $priceId');
      }
    } catch (e) {
      throw Exception('Failed to delete favorite: $e');
    }
  }
}
