import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarBrandItem extends StatelessWidget {
  const CarBrandItem({
    super.key,
    required this.name,
    required this.logo,
    required this.count,
  });

  final String name;
  final String logo;
  final String count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.h,

      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Image.network(
              logo,
              height: 45,
              width: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/logo_car_test.png",
                  height: 45,
                  width: 50,
                  fit: BoxFit.contain,
                );
              },
            ),
            const SizedBox(height: 5),
            Text(name, style: TextStyles.font14BlackRegular),
            Text(count, style: TextStyles.font12LightBlueMedium),
          ],
        ),
      ),
    );
  }
}
