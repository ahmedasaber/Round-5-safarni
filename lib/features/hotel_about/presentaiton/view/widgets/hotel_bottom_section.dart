import 'package:flutter/material.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/hotel_book_button.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/hotel_price_info.dart';

class HotelBottomSection extends StatelessWidget {
  final String price;

  const HotelBottomSection({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HotelPriceInfo(price: price),
        HotelBookButton(),
      ],
    );
  }
}