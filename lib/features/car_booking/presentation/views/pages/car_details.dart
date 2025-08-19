import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/car_booking/presentation/views/widgets/info_card.dart';
import 'package:safarni/features/car_booking/presentation/views/widgets/plan_card.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 400.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffF3F4F6),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r),
                    ),
                  ),

                  child: Image(
                    image: AssetImage("assets/images/car_test.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 24),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 24.r,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 18.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Popular Cars", style: TextStyles.font17BlackMedium),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  InfoCard(title: "Power", value: "429 hp @ 6,100 rpm"),
                  InfoCard(title: "Max Speed", value: "280 km/h"),
                  InfoCard(title: "Acceleration", value: "4.9 sec 0–60"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Plan", style: TextStyles.font17BlackMedium),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: PlanCard(
                      price: "\$10",
                      title: "Hourly Rent",
                      subtitle: "Best for business appointments",
                      isSelected: true,
                      icon: "assets/svgs/clock.svg",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PlanCard(
                      price: "\$80",
                      title: "Hourly Rent",
                      subtitle: "Best for business appointments",
                      isSelected: false,
                      icon: "assets/svgs/clock.svg",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Location", style: TextStyles.font14BlackMedium),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextFormField(
                initialValue: "200-298 Clipper St San Francisco",
                style: TextStyles.font13DarkGreyRegular,
                decoration: InputDecoration(
                  prefixIcon: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      "assets/svgs/location.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffF3F4F6), width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 16,
              ),
              child: CustomButton(
                text: "Pick up",
                color: AppColors.blue,
                textStyle: TextStyles.font16WhiteSemiBold,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
