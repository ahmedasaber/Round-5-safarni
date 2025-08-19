import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/core/utils/font_weight_helper.dart';

abstract class TextStyles {
  //padding and margin sizes
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  //Icon sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  //Default spacing between sections
  static const double defaultSpace = 24.0;
  static const double spaceBtwItems = 16.0;
  static const double spaceBtwSections = 32.0;

  // border radius
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 8.0;
  static const double borderRadiusLg = 12.0;
  static const double borderRadiusXlg = 30.0;

  //appBar height
  static const double appBarHeight = 56.0;

  // Font Sizes
  static const double fontSizeXs = 14.0;
  static const double fontSizeSm = 16.0;
  static const double fontSizeMd = 18.0;
  static const double fontSizeLg = 20.0;

  //Grid veiw spacing
  static const gridViewSpacing = 10.0;

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
  static TextStyle font14GreyRegular = TextStyle(
    fontSize: 14,
    color: AppColors.grey,
    fontWeight: FontWeight.w400,
  );
  static TextStyle font14LightGreyRegular = TextStyle(
    fontSize: 14,
    color: AppColors.lightGrey,
    fontWeight: FontWeight.w400,
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
  static TextStyle font13DarkGreyRegular = TextStyle(
    fontSize: 13,
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
  static TextStyle font14BlackMedium = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font15BlackRegular = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );
  static TextStyle font14BlackRegular = TextStyle(
    fontSize: 14,
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
  static TextStyle font12LightBlueMedium = TextStyle(
    fontSize: 12,
    color: AppColors.lightBlue,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font16WhiteSemiBold = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
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
  static TextStyle font16GrayLighterSemiBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.darkBlue,
  );
  static TextStyle font14DarkBlackNormal = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.darkBlack,
  );

  static const TextStyle medium12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle medium13 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle medium14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle medium16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle medium17 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle regular12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle regular13 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle regular14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle regular15 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle regular18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle semiBold12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle semiBold15 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle semiBold16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle semiBold17 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle semiBold20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle bold14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static TextStyle font15DarkBlueSemiBold = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.darkBlue,
  );
}
