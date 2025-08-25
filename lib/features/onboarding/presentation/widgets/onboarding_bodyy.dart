import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/onboarding_model.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnbordingModel model;
  final int currentIndex;
  final int pagesCount;
  final int pageIndex;

  const OnboardingPageWidget({
    super.key,
    required this.model,
    required this.currentIndex,
    required this.pagesCount,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [

        const SizedBox(height: 20),

        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              model.image,
              height: 500,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pagesCount,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.all(4),
              width: currentIndex == index ? 30 : 8,
              height: 10,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? AppColors.primary
                    : Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),

        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            model.desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
