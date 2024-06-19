import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutriscan/features/admin/controller/admin_controller.dart';
import 'package:nutriscan/utils/constants/image_strings.dart';
import 'package:nutriscan/utils/constants/sizes.dart';

import '../../../utils/constants/text_strings.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final controller = AdminController.instance;
    controller.barcodeController.text = id;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Text("Product ID: $id"),
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.spaceBtwSections),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: controller.imageFile.value != null
                                      ? Image.file(
                                          controller.imageFile.value!,
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        )
                                      : Image(
                                          image: AssetImage(
                                              "assets/images/content/upload_image_placeholder.png")),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // ImagePicker().pickImage(source: ImageSource.camera);
                                    controller
                                        .selectImage(); // Call to select an image
                                  },
                                  child: Text('Upload  Image'),
                                )
                              ],
                            ),
                          )),
                      const Text("Product Name"),
                      TextFormField(
                        controller: controller.nameController,
                        decoration: const InputDecoration(
                          labelText: "Enter product name",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      const Text("Brand"),
                      TextFormField(
                        controller: controller.brandController,
                        decoration: const InputDecoration(
                          labelText: "Enter brand name",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      const Text("Barcode"),
                      TextFormField(
                        // controller: controller.barcodeController,
                        decoration: const InputDecoration(
                          labelText: "Enter barcode",
                        ),
                        initialValue: id,
                        readOnly: true,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      const Text("Calories"),
                      TextFormField(
                        controller: controller.caloriesController,
                        decoration: const InputDecoration(
                          labelText: "Enter calories",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      const Text("Protein (g)"),
                      TextFormField(
                        controller: controller.proteinController,
                        decoration: const InputDecoration(
                          labelText: "Enter protein amount",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      const Text("Fat (g)"),
                      TextFormField(
                        controller: controller.fatController,
                        decoration: const InputDecoration(
                          labelText: "Enter fat amount",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      const Text("Carbohydrates (g)"),
                      TextFormField(
                        controller: controller.carbohydratesController,
                        decoration: const InputDecoration(
                          labelText: "Enter carbohydrates amount",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      const Text("Serving Size"),
                      TextFormField(
                        controller: controller.servingSizeController,
                        decoration: const InputDecoration(
                          labelText: "Enter serving size",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      const Text("Ingredients"),
                      TextFormField(
                        controller: controller.ingredientsController,
                        decoration: const InputDecoration(
                          labelText: "Enter ingredients",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      const Text("Allergens"),
                      TextFormField(
                        controller: controller.allergensController,
                        decoration: const InputDecoration(
                          labelText: "Enter allergens",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      const Text("Dietary Information"),
                      TextFormField(
                        controller: controller.dietaryInfoController,
                        decoration: const InputDecoration(
                          labelText:
                              "Enter dietary information (e.g., vegan, gluten-free)",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.addProduct(),
                          child: const Text("Save Product"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
