class Destination {
  final String name;
  final String price;
  final String tourType;
  final String rate;
  final String image;

  Destination({
    required this.image,
    required this.name,
    required this.price,
    required this.tourType,
    required this.rate,
  });
  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      name: json['name'] as String,
      price: json['price'] as String,
      tourType: json['tourType'] as String,
      rate: json['rate'] as String,
      image: json['image'] as String,
    );
  }
}
