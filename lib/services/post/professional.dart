import 'dart:convert';
import 'package:profinder/models/post/service.dart';
import 'package:profinder/models/post/service_creation_request.dart';
import 'package:http/http.dart' as http;
import 'package:profinder/models/post/service_detail.dart';
import 'package:profinder/models/post/service_update_request.dart';
import 'package:profinder/services/data.dart';
import 'package:profinder/services/user/authentication.dart';
import 'package:profinder/utils/constants.dart';
import 'package:profinder/utils/error_handler/business_error_handler.dart';
import 'package:profinder/utils/error_handler/error_payload.dart';

class ProfessionalService {
  final url = Constants.apiUrl;

  final GenericDataService<ServiceEntity> _genericService =
      GenericDataService<ServiceEntity>('service', {
    'get': 'viewall',
    'post': 'create',
  });

  Future<List<ServiceEntity>> fetch() async {
    return _genericService.fetch((json) => ServiceEntity.fromJson(json));
  }

  Future<Map<String, bool>> post(ServiceCreationRequest entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }

  Future<Map<String, bool>> delete(int serviceId) async {
    final response =
        await http.delete(Uri.parse('$url/service/delete/$serviceId'));

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      throw Exception('Failed to delete service');
    }
  }

  Future<Map<String, bool>> updateService(
      ServiceUpdateRequest body, int id) async {
    final String? jwtToken = await AuthenticationService.getJwtToken();
    final response = await http.patch(
      Uri.parse('$url/service/update/$id'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
      body: body.toJson(),
    );

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      ErrorPayload? errorPayload = await BusinessErrorHandler.checkErrorType();
      BusinessErrorHandler.handleError(errorPayload);

      throw Exception('Request failed with status ${response.statusCode}');
    }
  }

  Future<ServiceDetailEntity> fetchService(
      ServiceDetailEntity Function(
        Map<String, dynamic> json,
      ) fromJson,
      int? id) async {
    final response =
        await http.get(Uri.parse('$url/service/getoneservice/$id'));

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final jsonData = parsed['data'];

      final serviceEntity = fromJson(jsonData);
      return serviceEntity;
    } else {
      throw Exception('Failed to load service');
    }
  }

  Future<List<ServiceEntity>> fetchById(int? id) async {
    final response = await http.get(
      Uri.parse('$url/service/viewallb/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final jsonData = parsed['data'];

      final List<ServiceEntity> services = [];
      for (var item in jsonData) {
        final service = ServiceEntity.fromJson(item);
        services.add(service);
      }
      return services;
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
