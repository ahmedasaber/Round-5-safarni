import 'package:safarni/features/home/domain/entities/available_tours_entity.dart';

class TourModel extends ToursEntity {
  const TourModel({
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
  });

  /// Create a Model from JSON (API response)
  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'] as int,
      categoryId: json['category_id'] as int,
      title: json['title'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image'] as String,
      views: json['views'] as int,
      isRecommended: json['is_recommended'] as bool,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  /// Create a Model from Entity (useful for caching, mapping back, etc.)
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
    );
  }
}
