import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DestinationImage extends StatelessWidget {
  const DestinationImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 400.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/paris.jpg"),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
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
                InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24.r,
                    child: Icon(Icons.favorite, color: Colors.red, size: 24.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
