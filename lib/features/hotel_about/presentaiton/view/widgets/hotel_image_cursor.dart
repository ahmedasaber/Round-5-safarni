import 'package:flutter/material.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/image_cursor.dart';

class HotelImageCarousel extends StatelessWidget {
  final List<String> images;

  const HotelImageCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return ImageCarousel(
      images: images,
      height: MediaQuery.of(context).size.height * 0.4,
    );
  }
}