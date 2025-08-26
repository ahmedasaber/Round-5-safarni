import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../viewModel/view_model_onboarding.dart';
import '../widgets/onboarding_body.dart';
import '../../../auth/presentation/pages/get_start_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  static const routeName = '/onboarding-screen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: Consumer<OnboardingViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              centerTitle: false,
              title: Text(
                "Safarni",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      GetStartedPage.routeName,
                    );
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: vm.controller,
                      itemCount: vm.pages.length,
                      onPageChanged: vm.changePage,
                      itemBuilder: (context, index) {
                        return OnboardingPageWidget(
                          model: vm.pages[index],
                          currentIndex: vm.currentIndex,
                          pagesCount: vm.pages.length,
                          pageIndex: index,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: CustomButton(
                      text: vm.pages[vm.currentIndex].buttonText1,
                      onPressed: () {
                        if (vm.currentIndex == vm.pages.length - 1) {
                          Navigator.pushReplacementNamed(
                            context,
                            GetStartedPage.routeName,
                          );
                        } else {
                          vm.nextPage();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
