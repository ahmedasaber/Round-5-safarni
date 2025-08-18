import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToursSearchBar extends StatelessWidget {
  const ToursSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 14.h,
            bottom: 14.h,
            right: 4.w,
            left: 4.w,
          ),
          child: Container(
            height: 70.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: const Color(0xffD9DCF0).withOpacity(0.5),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            bottom: 20.h,
            left: 10.w,
            right: 10.w,
          ),
          child: SearchBar(
            side: WidgetStateProperty.all(
              const BorderSide(color: Color(0xff3F83F8)),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
            ),
            leading: Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: SvgPicture.asset(
                'assets/svgs/search_icon.svg',
                height: 30.h,
              ),
            ),
            backgroundColor: WidgetStateProperty.all(Colors.white),
          ),
        ),
      ],
    );
  }
}
