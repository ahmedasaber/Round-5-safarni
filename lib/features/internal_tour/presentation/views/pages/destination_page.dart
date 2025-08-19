import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/gallery.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/reviews.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/best_visit_time.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/booking_nav_bar.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/destination_image.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/top_activate_card.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/place_description_and_rating.dart';

class DestinationPage extends StatelessWidget {
  const DestinationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          DestinationImage(),

          SizedBox(height: 8.h),
          PlaceDescriptionAndRating(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  "Top Activates",
                  style: TextStyles.font17BlackMedium,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TopActivateCard(
                    image: "assets/images/activate1.jpg",
                    text: "Got to the top",
                  ),
                  SizedBox(width: 16.w),
                  TopActivateCard(
                    image: "assets/images/activate2.jpg",
                    text: "Louvre at Night",
                  ),
                ],
              ),
            ],
          ),
          BestVisitTime(),
          SizedBox(height: 16.h),
          Gallery(),

          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svgs/camera.svg"),
              SizedBox(width: 8.w),
              Text("Add photo", style: TextStyles.font15BlueMedium),
            ],
          ),
          SizedBox(height: 16.h),
          Reviews(),
        ],
      ),
      bottomNavigationBar: BookingNavBar(),
    );
  }
}
