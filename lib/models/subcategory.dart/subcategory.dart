class SubCategoryEntity {
  final String subCategoryId;
  final String subCategoryName;
  final String subCategoryPicture;
  final int categoryId;

  SubCategoryEntity({
    required this.subCategoryId,
    required this.subCategoryName,
    required this.subCategoryPicture,
    required this.categoryId,
  });

  factory SubCategoryEntity.fromJson(Map<String, dynamic> json) {
    return SubCategoryEntity(
      subCategoryId: json['subCategory_id'],
      subCategoryName: json['subCategory_name'],
      subCategoryPicture: json['subCategory_picture'],
      categoryId: json['category_id'],
    );
  }
}
