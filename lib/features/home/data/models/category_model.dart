import 'package:safarni/features/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.image,
    required super.title,
    required super.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      image: json['image'] as String? ?? '',
      title: json['title'] as String? ?? '', 
      description: json['description'] as String? ?? '', 
    );
  }

  factory CategoryModel.fromEntity(CategoryEntity categoryEntity) {
    return CategoryModel(
      image: categoryEntity.image,
      title: categoryEntity.title,
      description: categoryEntity.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {'image': image, 'title': title, 'description': description};
  }
}
