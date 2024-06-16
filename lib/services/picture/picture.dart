import 'dart:convert';

import 'package:profinder/models/picture/picture_creation_request.dart';
import 'package:profinder/services/data.dart';
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/constants.dart';
import 'package:http/http.dart' as http;

class PictureService {
  final apiUrl = Constants.apiUrl;
  final GenericDataService<PictureCreationRequest> _genericService =
      GenericDataService<PictureCreationRequest>('picture', {
    'post': 'add',
  });

  Future<Map<String, bool>> post(PictureCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }

  Future<Map<String, bool>> deleteById(int pictureId) async {
    final url = Uri.parse('$apiUrl/picture/delete/$pictureId');
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
        throw Exception('Failed to delete favorite with ID: $pictureId');
      }
    } catch (e) {
      throw Exception('Failed to delete favorite: $e');
    }
  }
}
