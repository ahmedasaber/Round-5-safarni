import 'package:flutter/material.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_styles.dart';

class PaymentCardInnerWidgets extends StatelessWidget {
  const PaymentCardInnerWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // شريحة chip + logos
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(AppAssets.chip, width: 40),
            Row(
              children: [
                Image.asset(AppAssets.touch, width: 40),
                const SizedBox(width: 8),
                Image.asset(AppAssets.contactless, width: 40),
                const SizedBox(width: 8),
                Image.asset(AppAssets.applePay, width: 40),
                const SizedBox(width: 8),
                Image.asset(AppAssets.googlePay, width: 40),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),

        const Text(
          "**** **** **** 1234",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        Column(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children: [
                      Text("VALID\nTHRU",
                          style:
                          TextStyle(color: Colors.white70, fontSize: 10)),
                      Text("01/22",
                          style:
                          TextStyle(color: Colors.white, fontSize: 14)),
                    ])
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Abuzer Firdousi",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: TextStyles.fontSizeSm,
                        fontWeight: FontWeight.w500)),
                Image.asset(AppAssets.basicMastercard, width: 40),
              ],
            )
          ],
        )
      ],
    );
  }
}
