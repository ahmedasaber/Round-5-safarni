import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/extensions.dart';

import '../../../../../core/utils/app_assets.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // to image
        Image.asset(
          AppAssets.flightImage,
          height: 259,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 50,
          left: 30,
          child: Row(
            children: [
               IconButton(icon: Icon(Icons.arrow_back_ios), color: Colors.white, onPressed: () => context.pop() ,),
              const SizedBox(width: 8),
              Text(
                "           Book Your Flight",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
