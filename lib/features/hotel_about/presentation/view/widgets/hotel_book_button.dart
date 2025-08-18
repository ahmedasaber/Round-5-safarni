import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/features/hotel_about/presentation/view/screens/book_hotel_model.dart';

class HotelBookButton extends StatelessWidget {
    final String price;
  final String? hotelName;
  final String? address;
  final double? rating;
  final int? reviewsCount;
  const HotelBookButton({super.key, required this.price, this.hotelName, this.address, this.rating, this.reviewsCount});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
              showBookHotelModal(
                context,
                hotelName: hotelName ?? 'HarborHaven Hideaway',
                address: address ?? '1012 Ocean Avenue, New York, USA',
                rating: rating ?? 4.5,
                reviewsCount: reviewsCount ?? 356,
                price: price,
              );
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkBlue,
        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        'Book Now',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
