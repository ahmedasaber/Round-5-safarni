import 'package:flutter/material.dart';

import '../../data/models/onboarding_model.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PageController controller = PageController();
  int currentIndex = 0;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      image: "assets/images/onbo1.png",
      desc: "Find Your Dream Adventure Here",
      buttonText1: "Next",
    ),
    OnboardingModel(
      image: "assets/images/onbor2.png",
      desc: "Easily Save Your Favorite Journeys",
      buttonText1: "Next",
    ),
    OnboardingModel(
      image: "assets/images/onbor3.png",
      desc: "Plan Your Dream Trip With TripMate",
      buttonText1: "Get Start",
    ),
  ];

  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
