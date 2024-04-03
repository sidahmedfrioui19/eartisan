import 'dart:convert';
import 'package:profinder/models/post/service.dart';
import 'package:profinder/services/data.dart';

class ProfessionalService {
  final GenericDataService<ServiceEntity> _genericService =
      GenericDataService<ServiceEntity>('service', {
    'get': 'viewall',
    'post': 'create',
  });

  Future<List<ServiceEntity>> fetch() async {
    return _genericService.fetch((json) => ServiceEntity.fromJson(json));
  }

  Future<Map<String, bool>> post(ServiceEntity entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body);
  }
}
