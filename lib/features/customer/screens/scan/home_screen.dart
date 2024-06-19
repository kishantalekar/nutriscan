import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriscan/features/customer/controller/user_controller.dart';
import 'package:nutriscan/features/customer/screens/scan/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          padding: const EdgeInsets.all(8.0),
          itemCount: userController.scannedItems.length,
          itemBuilder: (context, index) {
            final product = userController.scannedItems[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                leading: product.imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported),
                      )
                    : const Icon(Icons.image_not_supported, size: 50),
                title: Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.brand),
                    const SizedBox(height: 4),
                    Text('Calories: ${product.calories} kcal'),
                    Text('Serving Size: ${product.servingSize}'),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Get.to(() => ProductDetail(product: product));
                },
              ),
            );
          },
        );
      }),
    );
  }
}
