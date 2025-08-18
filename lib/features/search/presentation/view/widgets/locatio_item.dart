import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';

class LocationItem extends StatelessWidget {
  const LocationItem({
    super.key,
    required this.image,
    required this.location,
    required this.knownBy,
  });

  final String image, location, knownBy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Container(
              color: Color(0xffebf5ff),
              child: SvgPicture.asset(
                image,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4.0),
                Text(location, style: TextStyles.medium12),
                const SizedBox(height: 4.0),
                Text(knownBy, style: TextStyles.regular13.copyWith(color: AppColors.grayColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
