import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriscan/features/customer/controller/user_controller.dart';
import 'package:nutriscan/features/customer/screens/scan/product_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanned History"),
      ),
      body: Obx(() {
        if (userController.scannedItems.isEmpty) {
          return const Center(child: Text("No scanned items yet"));
        }

        return ListView.builder(
          itemCount: userController.scannedItems.length,
          itemBuilder: (context, index) {
            final product = userController.scannedItems[index];
            return ListTile(
              leading: product.imageUrl.length > 5
                  ? Image.network(product.imageUrl!,
                      width: 50, height: 50, fit: BoxFit.cover)
                  : const Icon(Icons.image_not_supported),
              title: Text(product.name),
              subtitle: Text(product.brand),
              onTap: () {
                Get.to(() => ProductDetail(product: product));
              },
            );
          },
        );
      }),
    );
  }
}
