import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_colors.dart';

class HotelBookButton extends StatelessWidget {
  const HotelBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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
