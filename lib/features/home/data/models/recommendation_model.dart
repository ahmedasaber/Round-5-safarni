import 'package:safarni/features/home/domain/entities/recommendation_entity.dart';

class RecommendationModel extends RecommendationEntity {
  RecommendationModel({
    required super.title,
    required super.location,
    required super.description,
    required super.price,
    required super.image,
    required super.views,
    required super.rating,
  });

  factory RecommendationModel.fromEntity(RecommendationEntity recommendationEntity) {
    return RecommendationModel(
      title: recommendationEntity.title,
      location: recommendationEntity.location,
      description: recommendationEntity.description,
      price: recommendationEntity.price,
      image: recommendationEntity.image,
      views: recommendationEntity.views,
      rating: recommendationEntity.rating,
    );
  }

  factory RecommendationModel.fromJson(Map<String, dynamic> json){
    return RecommendationModel(
        title: json['title'],
        location: json['location'],
        description: json['description'],
        price: json['price'],
        image: json['image'],
        views: json['views'],
        rating: json['rating']
    );
  }
}
