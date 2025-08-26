import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/internal_tour/presentation/cubit/tour_cubit.dart';

class ToursSearchBar extends StatelessWidget {
  const ToursSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
      child: Stack(
        children: [
          Container(
            height: 80.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: const Color(0xffD9DCF0).withOpacity(0.5),
            ),
          ),

          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
              child: SearchBar(
                onChanged: (value) {
                  context.read<TourCubit>().searchTours(value);
                },
                side: WidgetStateProperty.all(
                  const BorderSide(color: Color(0xff3F83F8)),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
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
          ),
        ],
      ),
    );
  }
}
