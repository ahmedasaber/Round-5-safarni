class HotelModel {
  final int id;
  final String name;
  final String location;
  final String image;
  final double averageRating;

  HotelModel({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.averageRating,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      image: json['image'] ?? '',
      averageRating: (json['average_rating'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'image': image,
      'average_rating': averageRating,
    };
  }
}