// import 'package:nutriscan/features/authentication/controllers/login/login_controller.dart';
// import 'package:nutriscan/utils/constants/colors.dart';
// import 'package:nutriscan/utils/constants/image_strings.dart';
// import 'package:nutriscan/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TSocialButtons extends StatelessWidget {
//   const TSocialButtons({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(LoginController());
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: TColors.grey),
//             borderRadius: BorderRadius.circular(100),
//           ),
//           child: IconButton(
//             icon: const Image(
//               height: TSizes.md,
//               width: TSizes.md,
//               image: AssetImage(TImages.google),
//             ),
//             onPressed: () => controller.googleSignIn(),
//           ),
//         ),
//         const SizedBox(
//           width: TSizes.spaceBtwItems,
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: TColors.grey),
//             borderRadius: BorderRadius.circular(100),
//           ),
//           child: IconButton(
//             icon: const Image(
//               height: TSizes.md,
//               width: TSizes.md,
//               image: AssetImage(TImages.facebook),
//             ),
//             onPressed: () {},
//           ),
//         ),
//       ],
//     );
//   }
// }
