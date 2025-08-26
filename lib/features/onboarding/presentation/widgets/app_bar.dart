import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(

      backgroundColor: Colors.white,
      centerTitle: false,
      title: const Text(
        "Safarni",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      actions: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 4),
              child: Text(
                "Skip",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
            ),
          ],
        ),
        SizedBox(width: 8),
      ],


    );
  }
}
