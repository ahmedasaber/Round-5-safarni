import 'package:flutter/material.dart';
import 'package:safarni/core/utils/routes.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarCard extends StatelessWidget {
  const CarCard({
    super.key,
    required this.name,
    required this.fuelType,
    required this.numberOfSeats,
    required this.driveMode,
    required this.carImage,
  });
  final String name;
  final String fuelType;
  final String numberOfSeats;
  final String driveMode;
  final String carImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.carDetailsPage),
            child: Card(
              elevation: 3,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(driveMode, style: TextStyles.font14GreyRegular),
                        const SizedBox(width: 4),
                        Text('|', style: TextStyles.font14LightGreyRegular),
                        const SizedBox(width: 4),
                        Text(
                          numberOfSeats,
                          style: TextStyles.font14GreyRegular,
                        ),
                        const SizedBox(width: 4),
                        Text('|', style: TextStyles.font14LightGreyRegular),
                        const SizedBox(width: 4),
                        Text(fuelType, style: TextStyles.font14GreyRegular),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          color: AppColors.blue,
                          text: "Rent Now",
                          textStyle: TextStyles.font16WhiteSemiBold,
                        ),
                        SizedBox(width: 18.w),
                        CustomButton(
                          color: Colors.white,
                          text: "Detail",
                          textStyle: TextStyles.font16BlueSemiBold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: -60,
            right: -10,
            child: Image.asset(carImage, width: 150, height: 150),
          ),
        ],
      ),
    );
  }
}
