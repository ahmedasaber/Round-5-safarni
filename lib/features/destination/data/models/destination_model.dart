import '../../domain/entities/destination.dart';

class DestinationModel extends Destination {
  DestinationModel({
    required super.id,
    required super.title,
    required super.location,
    required super.duration,
    required super.rating,
    required super.reviewsCount,
    required super.description,
    required super.images,
    required super.topActivities,
    required super.bestTimeToVisit,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'],
      title: json['title'],
      location: json['location'],
      duration: json['duration'],
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'],
      description: json['description'],
      images: List<String>.from(json['images']),
      topActivities: List<String>.from(json['topActivities']),
      bestTimeToVisit: json['bestTimeToVisit'],
    );
  }
}
