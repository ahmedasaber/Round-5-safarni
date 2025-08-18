import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:safarni/core/utils/app_colors.dart';

abstract class TextStyles {
  static TextStyle font12GreySemibold = TextStyle(
    fontSize: 12,
    color: AppColors.grey,
    fontWeight: FontWeight.w600,
  );

  static TextStyle font14GreyBold = TextStyle(
    fontSize: 14,
    color: AppColors.grey,

    fontWeight: FontWeight.w700,
  );
  static TextStyle font10GreySemiBold = TextStyle(
    fontSize: 10,
    color: AppColors.grey,

    fontWeight: FontWeight.w600,
  );
  static TextStyle font12GreyMedium = TextStyle(
    fontSize: 12,
    color: AppColors.grey,

    fontWeight: FontWeight.w500,
  );
  static TextStyle font12DarkGreySemiBold = TextStyle(
    fontSize: 12,
    color: AppColors.darkGrey,

    fontWeight: FontWeight.w600,
  );
  static TextStyle font14DarkGreyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.darkGrey,

    fontWeight: FontWeight.w500,
  );
  static TextStyle font12DarkGreyRegular = TextStyle(
    fontSize: 12,
    color: AppColors.darkGrey,

    fontWeight: FontWeight.w400,
  );
  static TextStyle font13DarkGreyMedium = TextStyle(
    fontSize: 13,
    color: AppColors.darkGrey,

    fontWeight: FontWeight.w500,
  );

  static TextStyle font17BlackMedium = TextStyle(
    fontSize: 17,
    color: Colors.black,

    fontWeight: FontWeight.w500,
  );
  static TextStyle font15BlackRegular = TextStyle(
    fontSize: 15,
    color: Colors.black,

    fontWeight: FontWeight.w400,
  );
  static TextStyle font16BlackRegular = TextStyle(
    fontSize: 16,
    color: Colors.black,

    fontWeight: FontWeight.w400,
  );
  static TextStyle font16BlackMedium = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font18BlackMedium = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font16BlackSemiBold = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font17BlueMedium = TextStyle(
    fontSize: 17,
    color: AppColors.blue,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font15BlueMedium = TextStyle(
    fontSize: 15,
    color: AppColors.blue,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font16BlueSemiBold = TextStyle(
    fontSize: 16,
    color: AppColors.blue,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font17BlueSemiBold = TextStyle(
    fontSize: 16,
    color: AppColors.blue,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font16WhiteSemiBold = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
=======
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/font_weight_helper.dart';

abstract class TextStyles {
  static TextStyle font15LightGrayNormal = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeightHelper.normal,
    color: AppColors.lightGrey,
  );
  static TextStyle font17LightBlackNormal = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.lightBlack,
  );
  static TextStyle font15DarkBlueNormal = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.darkBlue,
  );
  static TextStyle font12DarkBlueNormal = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.darkBlue,
  );
  static TextStyle font12DarkGrayNormal = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.darkGray,
  );
  static TextStyle font16LightBlackNormal = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.lightBlack,
  );
  static TextStyle font14DarkGrayNormal = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.normal,
    color: AppColors.darkGray,
  );
  static TextStyle font13LightBlackNormal = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.lightBlack,
  );
  static TextStyle font13LightBlueNormal = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.lightBlue,
  );
  static TextStyle font20LightBlackNormal = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.lightBlack,
  );
  static TextStyle font17DarkBlueNormal = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.darkBlue,
  );
    static TextStyle font18DarkBlackNormal = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.darkBlack,
  );
      static TextStyle font16DarkBlackNormal = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.darkBlack,
    height: 1.4,
  );
    static TextStyle font20DarkBlueNormal = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.darkBlue,
>>>>>>> 296de0e1da378c200631a2009c892649eaa5068c
  );
}
