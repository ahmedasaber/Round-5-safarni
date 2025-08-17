import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class HotelPriceInfo extends StatelessWidget {
  final String price;

  const HotelPriceInfo({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total price', style: TextStyles.font16LightBlackNormal),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$$price',
                  style: TextStyles.font17DarkBlueNormal,
                ),
                TextSpan(
                  text: '/night',
                  style: TextStyles.font15LightGrayNormal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
