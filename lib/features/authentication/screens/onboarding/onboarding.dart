import 'package:nutriscan/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:nutriscan/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:nutriscan/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:nutriscan/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:nutriscan/features/authentication/screens/onboarding/widgets/skip_button.dart';
import 'package:nutriscan/utils/constants/image_strings.dart';
import 'package:nutriscan/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: "assets/images/content/Food1.png",
                title: "Local, Customized\nMeal Planning",
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: "assets/images/content/food2.png",
                title:
                    "Create your own customized meal plan from our selection of healthy meal options.",
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: "assets/images/content/food3.png",
                title:
                    "Enjoy healthy and delicious meals delivered to your doorstep, prepared with fresh, high-quality ingredients.",
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          const SkipButton(),
          OnBoardingDotNavigation(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
