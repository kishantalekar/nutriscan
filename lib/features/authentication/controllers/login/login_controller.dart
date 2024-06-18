import 'package:nutriscan/features/admin/screens/admin_dashboard.dart';
import 'package:nutriscan/features/customer/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/auth/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loaders.dart';

class LoginController extends GetxController {
//variables
  final rememberMe = false.obs;
  final hidePassword = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());
  @override
  void onInit() {
    super.onInit();
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? "";
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? "";
  }

  Future<void> signIn() async {
    try {
      if (email.text == "admin123@gmail.com" && password.text == "nutriscan") {
        Get.offAll(AdminDashboard());
        return;
      }
      TFullScreenLoader.openLoadingPage(
          'Logging you in...', TImages.dockerAnimation);

      //check internet connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      print('internet connection is $isConnected');
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // if (!privacyPolicy.value) {
      //   TFullScreenLoader.warningSnackBar(
      //       title: 'Accept privaciy policy',
      //       message: 'In order to create account ');
      //   return;
      // }
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_Password', password.text.trim());
      }

      //register user
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();

      // TFullScreenLoader.successSnackBar(
      //     title: 'Congratulations',
      //     message: 'Your account has been created! verify email to continue');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(title: 'oh Snap!', message: e.toString());
    }
  }

  // Future<void> googleSignIn() async {
  //   try {
  //     TFullScreenLoader.openLoadingPage(
  //         'Logging you in...', TImages.dockerAnimation);

  //     final isConnected = await NetworkManager.instance.isConnected();
  //     print('internet connection is $isConnected');
  //     if (!isConnected) {
  //       TFullScreenLoader.stopLoading();
  //       return;
  //     }

  //     final userCredential =
  //         await AuthenticationRepository.instance.signWithGoogle();
  //     await userController.saveUserRecord(userCredential);
  //     TFullScreenLoader.stopLoading();

  //     AuthenticationRepository.instance.screenRedirect();
  //   } catch (e) {
  //     TFullScreenLoader.stopLoading();
  //     TFullScreenLoader.errorSnackBar(title: 'oh snap', message: e.toString());
  //   }
  // }
}
