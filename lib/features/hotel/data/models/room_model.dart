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
    print('🔍 Parsing room JSON: $json');

    try {
      int parsedId = 0;
      final rawId = json['id'];
      print('Raw ID: $rawId (${rawId.runtimeType})');

      if (rawId is int) {
        parsedId = rawId;
      } else if (rawId is String) {
        parsedId = int.tryParse(rawId) ?? 0;
      } else if (rawId is double) {
        parsedId = rawId.toInt();
      }

      // Safe parsing for name
      final rawName = json['name'];
      String parsedName = '';
      if (rawName != null) {
        parsedName = rawName.toString();
      }

      // Safe parsing for image
      final rawImage = json['image'];
      String parsedImage = '';
      if (rawImage != null) {
        parsedImage = rawImage.toString();
      }

      // Safe parsing for price
      double parsedPrice = 0.0;
      final rawPrice = json['price'];
      print('Raw Price: $rawPrice (${rawPrice.runtimeType})');

      if (rawPrice is double) {
        parsedPrice = rawPrice;
      } else if (rawPrice is int) {
        parsedPrice = rawPrice.toDouble();
      } else if (rawPrice is String) {
        parsedPrice = double.tryParse(rawPrice) ?? 0.0;
      }

      final room = RoomModel(
        id: parsedId,
        name: parsedName,
        image: parsedImage,
        price: parsedPrice,
      );

      print('✅ Successfully parsed room: ${room.id} - ${room.name}');
      return room;
    } catch (e, stackTrace) {
      print('❌ Error parsing room: $e');
      print('Stack trace: $stackTrace');
      print('JSON data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'price': price};
  }
}
