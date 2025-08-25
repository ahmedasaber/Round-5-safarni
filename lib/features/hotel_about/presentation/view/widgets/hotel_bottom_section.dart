import 'package:flutter/material.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/hotel_book_button.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/hotel_price_info.dart';

class HotelBottomSection extends StatelessWidget {
  final String price;
  final String? hotelName;
  final String? address;
  final double? rating;
  final int? reviewsCount;
  final int? roomId;

  const HotelBottomSection({
    super.key,
    required this.price,
    this.hotelName,
    this.address,
    this.rating,
    this.reviewsCount,
    this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    // Print room ID for debugging
    print('💰 HotelBottomSection - Room ID: $roomId');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HotelPriceInfo(price: price),
        HotelBookButton(
          price: price, // إصلاح هنا - كان فيه '\$price' غلط
          hotelName: hotelName,
          address: address,
          rating: rating,
          reviewsCount: reviewsCount,
          roomId: roomId, // مرر الـ room ID
        ),
      ],
    );
  }
}
