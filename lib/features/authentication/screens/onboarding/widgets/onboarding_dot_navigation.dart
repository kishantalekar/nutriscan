import 'package:nutriscan/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:nutriscan/utils/constants/colors.dart';
import 'package:nutriscan/utils/constants/sizes.dart';
import 'package:nutriscan/utils/device/device_utility.dart';
import 'package:nutriscan/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  OnBoardingDotNavigation({
    super.key,
  });
  final controller = OnBoardingController.instance;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: TSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationOnClick,
        count: 3,
        effect: ExpandingDotsEffect(
            activeDotColor: dark ? TColors.light : TColors.light, dotHeight: 6),
      ),
    );
  }
}
