import 'package:profinder/models/category.dart';
import 'package:profinder/services/data.dart';

class CategoryService {
  final GenericDataService<CategoryEntity> _genericService =
      GenericDataService<CategoryEntity>('category', {
    'get': 'view',
  });

  final String path = 'category';

  Future<List<CategoryEntity>> fetch() async {
    return _genericService.fetch((json) => CategoryEntity.fromJson(json));
  }
}
