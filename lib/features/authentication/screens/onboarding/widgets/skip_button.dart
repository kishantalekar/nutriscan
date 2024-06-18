import 'package:nutriscan/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:nutriscan/utils/constants/sizes.dart';
import 'package:nutriscan/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: controller.skipPage,
        child: const Text("Skip"),
      ),
    );
  }
}
