import 'package:nutriscan/data/auth/authentication_repository.dart';
import 'package:nutriscan/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:nutriscan/utils/constants/image_strings.dart';
import 'package:nutriscan/utils/helpers/network_manager.dart';
import 'package:nutriscan/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();
  final email = TextEditingController();

  GlobalKey<FormState> forgetPasswordKey = GlobalKey<FormState>();

  //send email
  sendPasswordResetEmail() async {
    try {
      TFullScreenLoader.openLoadingPage(
          "processing your request", TImages.dockerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!forgetPasswordKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());
      TFullScreenLoader.stopLoading();

      TFullScreenLoader.successSnackBar(
          title: 'Email sent',
          message: "Email link Sent to Reset your password".tr);

      Get.to(() => ResetPassword(
            email: email.text.trim(),
          ));
    } catch (e) {
      print(e);
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(
          title: "Oh snap", message: "Error in sending email $e");
    }
  }

  //reset password
  resendPasswordResetEmail(String email) async {
    try {
      TFullScreenLoader.openLoadingPage(
          "processing your request", TImages.dockerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);
      TFullScreenLoader.stopLoading();

      TFullScreenLoader.successSnackBar(
          title: 'Email sent',
          message: "Email link Sent to Reset your password".tr);
    } catch (e) {
      print(e);
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(
          title: "Oh snap", message: "Error in sending email $e");
    }
  }
}
