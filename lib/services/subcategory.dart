import 'package:profinder/models/subcategory.dart/subcategory.dart';
import 'package:profinder/services/data.dart';

class CategoryService {
  final GenericDataService<SubCategoryEntity> _genericService =
      GenericDataService<SubCategoryEntity>('subcategory', {
    'get': 'view',
  });

  final String path = 'subcategory';

  Future<List<SubCategoryEntity>> fetch() async {
    return _genericService.fetch((json) => SubCategoryEntity.fromJson(json));
  }
}
