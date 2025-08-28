import 'package:safarni/features/home/domain/entities/available_tours_entity.dart';

class TourModel extends ToursEntity {
   TourModel({
    required super.id,
    required super.categoryId,
    required super.title,
    required super.location,
    required super.description,
    required super.price,
    required super.image,
    required super.views,
    required super.isRecommended,
    required super.rating,
    super.isFav
  });

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'] as int? ?? 0, 
      categoryId: json['category_id'] as int? ?? 0,
      title: json['title'] as String? ?? '', 
      location: json['location'] as String? ?? '', 
      description: json['description'] as String? ?? '', 
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      image: json['image'] as String? ?? '', 
      views: json['views'] as int? ?? 0,
      isRecommended: json['is_recommended'] as bool? ?? false, 
      rating: double.tryParse(json['rating']?.toString() ?? '0') ?? 0.0, 
      isFav: json['isFavorite'] as bool? ?? false,
    );
  }

  factory TourModel.fromEntity(ToursEntity entity) {
    return TourModel(
      id: entity.id,
      categoryId: entity.categoryId,
      title: entity.title,
      location: entity.location,
      description: entity.description,
      price: entity.price,
      image: entity.image,
      views: entity.views,
      isRecommended: entity.isRecommended,
      rating: entity.rating,
      isFav: entity.isFav,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'title': title,
      'location': location,
      'description': description,
      'price': price,
      'image': image,
      'views': views,
      'is_recommended': isRecommended,
      'rating': rating,
      'isFavorite': isFav,
    };
  }
}