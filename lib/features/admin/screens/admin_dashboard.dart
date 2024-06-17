import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriscan/features/admin/model/product_model.dart';
import 'package:nutriscan/features/admin/screens/add_product.dart';
import 'package:nutriscan/features/admin/screens/edit_product.dart';
import 'package:nutriscan/features/admin/screens/product_details.dart';
import 'package:nutriscan/utils/constants/sizes.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../controller/admin_controller.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (adminController.products.isEmpty) {
            return Center(child: Text("No products found"));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: adminController.products.length,
                  itemBuilder: (context, index) {
                    final product = adminController.products[index];
                    return Card(
                      child: ListTile(
                        onTap: () =>
                            Get.to(() => ProductDetails(product: product)),
                        title: Text(product.name),
                        subtitle: Text(
                            "Brand: ${product.brand}\nBarcode: ${product.barcode}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Get.to(EditProduct(product: product));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Delete Product"),
                                      content: Text(
                                          "Are you sure you want to delete ${product.name}?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            adminController
                                                .deleteProduct(product.id);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Delete"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () async {
            var res = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SimpleBarcodeScannerPage(),
                ));
            if (res != null) {
              Get.to(AddProduct(id: res));
            }
          },
          child: const Text('Add Product'),
        ),
      ),
    );
  }

  void _showDeleteDialog(Product product) {}
}
