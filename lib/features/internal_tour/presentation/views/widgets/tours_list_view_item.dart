import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safarni/core/utils/routes.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/internal_tour/data/models/tours.dart';

class ToursListViewItem extends StatelessWidget {
  final Tour tour;

  const ToursListViewItem({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.destinationPage, arguments: tour);
      },
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: Row(
          children: [
            Container(
              height: 88.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  tour.image ?? "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tour.location ?? "Tour",
                        style: TextStyles.font12GreySemibold,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/star.svg",
                              width: 16.w,
                              height: 16.h,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "${tour.rating ?? 0.0}",
                              style: TextStyles.font12DarkGreySemiBold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  Text(
                    tour.title ?? "Unknown Tour",
                    style: TextStyles.font16BlackMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "From ",
                          style: TextStyles.font14GreyBold,
                        ),
                        TextSpan(
                          text: "${tour.price ?? '0'}\$",
                          style: TextStyles.font14GreyBold.copyWith(
                            color: const Color(0xff1C64F2),
                          ),
                        ),
                        TextSpan(
                          text: " Per person",
                          style: TextStyles.font14GreyBold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
