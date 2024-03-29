class CategoryEntity {
  final int id;
  final String name;
  final String picture;
  final String icon;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.picture,
    required this.icon,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      id: json['category_id'],
      name: json['category_name'],
      picture: json['category_picture'],
      icon: json['category_icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': id,
      'category_name': name,
      'category_picture': picture,
      'category_icon': icon,
    };
  }
}
