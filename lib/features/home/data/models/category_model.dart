import 'package:safarni/features/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity{
  CategoryModel({required super.image, required super.title, required super.description});

  factory CategoryModel.fromJson(Map<String,dynamic> json){
    return CategoryModel(image: json['image'], title: json['title'], description: json['description']);
  }

  factory CategoryModel.fomEntity(CategoryEntity categoryEntity){
    return CategoryModel(image: categoryEntity.image, title: categoryEntity.title, description: categoryEntity.description);
  }
}