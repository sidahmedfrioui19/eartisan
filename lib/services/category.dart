import 'dart:convert';
import 'package:profinder/models/category.dart';
import 'package:profinder/services/data.dart';

class CategoryService {
  final GenericDataService<CategoryEntity> _genericService =
      GenericDataService<CategoryEntity>('category', {
    'get': 'view',
    'post': 'add',
  });

  final String path = 'category';

  Future<List<CategoryEntity>> fetch() async {
    return _genericService.fetch((json) => CategoryEntity.fromJson(json));
  }

  Future<CategoryEntity> post(CategoryEntity entity) async {
    final String body = jsonEncode(entity.toJson());
    return _genericService.post(body, (json) => CategoryEntity.fromJson(json));
  }
}
