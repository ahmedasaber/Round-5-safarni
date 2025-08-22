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
    try {
      return HotelModel(
        id: _parseToInt(json['id']),
        name: _parseToString(json['name']),
        location: _parseToString(json['location']),
        image: _parseToString(json['image']),
        averageRating: _parseToDouble(json['average_rating']),
      );
    } catch (e) {
      throw Exception('Failed to parse HotelModel: $e');
    }
  }

  // Helper methods لتحويل الأنواع بأمان
  static int _parseToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }

  static String _parseToString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  static double _parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
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