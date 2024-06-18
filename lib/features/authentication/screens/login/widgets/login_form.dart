import 'package:nutriscan/features/authentication/controllers/login/login_controller.dart';
import 'package:nutriscan/features/authentication/screens/password_configuration/forgot_password.dart';
import 'package:nutriscan/features/authentication/screens/signup/signup.dart';
// import 'package:nutriscan/navigation_menu.dart';
import 'package:nutriscan/utils/constants/sizes.dart';
import 'package:nutriscan/utils/constants/text_strings.dart';
import 'package:nutriscan/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefix: Icon(Iconsax.direct_right), labelText: TTexts.email),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Obx(
              () => TextFormField(
                obscureText: controller.hidePassword.value,
                validator: (value) => TValidator.validatePassword(value),
                controller: controller.password,
                decoration: InputDecoration(
                    prefix: const Icon(Iconsax.password_check),
                    labelText: TTexts.password,
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye))),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),

            //remember me and forgot password

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) {
                          controller.rememberMe.value = value ?? false;
                        },
                      ),
                    ),
                    const Text(TTexts.rememberMe)
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => const ForgotPassword());
                  },
                  child: const Text(TTexts.forgetPassword),
                )
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.signIn(),
                    child: const Text(TTexts.signIn))),

            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      Get.to(() => const SignupScreen());
                    },
                    child: const Text(TTexts.createAccount))),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
          ],
        ),
      ),
    );
  }
}
