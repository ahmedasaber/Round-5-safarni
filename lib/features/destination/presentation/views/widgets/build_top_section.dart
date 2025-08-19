import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safarni/core/common/widgets/circular_icon.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_colors.dart';

class BuildTopSection extends StatelessWidget {
  const BuildTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppAssets.destinationImageSlider1, // Replace with your image path
          fit: BoxFit.cover,
          height: 350,
          width: double.infinity,
        ),

        //back button
        Positioned(
          top: 40,
          left: 10,
          child: IconButton(
            icon: CircularIcon(
              icon: Icons.arrow_back_ios,
              color: Colors.black),
            onPressed: () {},
          ),
        ),

        // favorite button
        Positioned(
          top: 40,
          right: 10,
          child: CircularIcon(
            onPressed: (){},
            icon: Iconsax.heart5,
            color: AppColors.black,
          )
        ),
        Positioned(
          bottom: 20,
          right: 160,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(Icons.image, color: Colors.black, size: 16),
                SizedBox(width: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '4',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: '/9',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
