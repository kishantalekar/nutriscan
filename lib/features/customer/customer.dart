import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nutriscan/features/admin/controller/admin_controller.dart';
import 'package:nutriscan/features/customer/controller/user_controller.dart';
import 'package:nutriscan/features/customer/product_details.dart';
import 'package:nutriscan/features/customer/screens/expiry_tracker.dart';
import 'package:nutriscan/features/customer/screens/home_screen.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../utils/constants/colors.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer"),
      ),
      body: Obx(() {
        return controller.screens[controller.selectedIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (value) {
            controller.onDestinationSelected(context, value);
          },
          backgroundColor: Colors.white,
          indicatorColor: TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.camera), label: "Scan"),
            NavigationDestination(icon: Icon(Iconsax.timer), label: "Expiry")
          ],
        );
      }),
    );
  }
}
