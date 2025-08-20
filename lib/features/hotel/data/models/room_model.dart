class RoomModel {
  final int id;
  final String name;
  final String image;
  final double price;

  RoomModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
    };
  }
}