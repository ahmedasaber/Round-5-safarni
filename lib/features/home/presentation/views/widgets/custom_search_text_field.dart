import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    super.key,
    this.onTap,
    this.readOnly = false,
    this.onChange,
  });

  final VoidCallback? onTap;
  final ValueChanged? onChange;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: readOnly
              ? BorderRadius.circular(10)
              : BorderRadius.circular(16),
          border: Border.all(
            color: readOnly ? Color(0xffE5E7EB) : Color(0xff3f83f8),
          ),
          boxShadow: [
            !readOnly
                ? BoxShadow(
                    color: Color(0xffd9dcf0),
                    blurRadius: 2,
                    spreadRadius: 3,
                  )
                : BoxShadow(),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: TextField(
            onTap: onTap,
            onChanged: onChange,
            readOnly: readOnly,
            decoration: InputDecoration(
              hintText: 'Search ...',
              hintStyle: readOnly
                  ? TextStyles.regular15.copyWith(color: AppColors.grayColor)
                  : TextStyles.regular15.copyWith(color: Color(0xff3f83f8)),
              icon: readOnly
                  ? SvgPicture.asset('assets/icons/search-normal.svg')
                  : SvgPicture.asset('assets/icons/search-normal-blue.svg'),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
