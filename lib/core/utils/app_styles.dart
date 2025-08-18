import 'package:flutter/material.dart';
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
  );
  static const TextStyle medium12= TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  static const TextStyle medium13= TextStyle(fontSize: 13, fontWeight: FontWeight.w500);
  static const TextStyle medium14= TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const TextStyle medium16= TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const TextStyle medium17= TextStyle(fontSize: 17, fontWeight: FontWeight.w500);
  static const TextStyle regular12= TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  static const TextStyle regular13= TextStyle(fontSize: 13, fontWeight: FontWeight.w400);
  static const TextStyle regular14= TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const TextStyle regular15= TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
  static const TextStyle regular18= TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  static const TextStyle semiBold12= TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  static const TextStyle semiBold15= TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  static const TextStyle semiBold16= TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const TextStyle semiBold17= TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
  static const TextStyle semiBold20= TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static const TextStyle bold14= TextStyle(fontSize: 14, fontWeight: FontWeight.w700);
}