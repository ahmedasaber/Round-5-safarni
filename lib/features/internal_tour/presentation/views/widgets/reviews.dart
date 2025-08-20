import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/review_card.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/custom_outlined_button.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Reviews", style: TextStyles.font17BlackMedium),
              const SizedBox(height: 12),
              ReviewCard(
                avatar: "assets/images/figure.jpg",
                name: "Dale Thiel",
                time: "11 months ago",
                review:
                    "Such a dreamy place! The views were stunning, and the atmosphere was so romantic. It felt like a fairytale moment in the heart of Paris.",
              ),

              ReviewCard(
                avatar: "assets/images/figure.jpg",
                name: "Léo Martin",
                time: "6 months ago",
                review:
                    "A beautiful escape from the ordinary. Everything was elegant and peaceful — the perfect setting for a special night in Paris.",
              ),
              SizedBox(height: 20.h),
              CustomOutlinedButton(text: "See more"),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ],
    );
  }
}
