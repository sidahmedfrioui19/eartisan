import 'package:profinder/models/category/category.dart';
import 'package:profinder/models/subcategory.dart/subcategory.dart';
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

  Future<List<SubCategoryEntity>> fetchSubcategories(int categoryId) async {
    // Fetch all categories
    List<CategoryEntity> categories = await fetch();

    // Find the category with the provided categoryId
    CategoryEntity category = categories.firstWhere(
      (category) => category.id == categoryId,
      orElse: () => throw Exception('Category not found'),
    );

    // Return subcategories of the found category
    return List<SubCategoryEntity>.from(category.subcategories);
  }
}
