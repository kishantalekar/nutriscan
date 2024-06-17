import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nutriscan/utils/constants/image_strings.dart';
import 'package:nutriscan/utils/constants/sizes.dart';
import 'package:nutriscan/utils/constants/text_strings.dart';
import 'package:nutriscan/utils/helpers/helper_functions.dart';
import '../controller/admin_controller.dart';
import '../model/product_model.dart';

class EditProduct extends StatelessWidget {
  final Product product;
  final AdminController controller = AdminController.instance;

  EditProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    controller.idController.text = product.id;
    controller.nameController.text = product.name;
    controller.brandController.text = product.brand;
    controller.barcodeController.text = product.barcode;
    controller.caloriesController.text = product.calories.toString();
    controller.proteinController.text = product.protein.toString();
    controller.fatController.text = product.fat.toString();
    controller.carbohydratesController.text = product.carbohydrates.toString();
    controller.servingSizeController.text = product.servingSize;
    controller.ingredientsController.text = product.ingredients;
    controller.allergensController.text = product.allergens;
    controller.dietaryInfoController.text = product.dietaryInfo;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Text("Product ID: ${product.id}"),
              Gap(10),
              Obx(
                () => Center(
                  child: Image(
                    width: THelperFunctions.screenWidth() * 0.5,
                    height: 400,
                    fit: BoxFit.contain,
                    image: controller.imageFile.value != null
                        ? FileImage(controller.imageFile.value!)
                        : product.imageUrl.length > 5
                            ? NetworkImage(product.imageUrl) as ImageProvider
                            : AssetImage(TImages.imagePlaceholder),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // ImagePicker().pickImage(source: ImageSource.camera);
                  controller.selectImage(); // Call to select an image
                },
                child: Text('Upload  Image'),
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.spaceBtwSections),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.nameController,
                        decoration: InputDecoration(
                          labelText: "Product Name",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.brandController,
                        decoration: InputDecoration(
                          labelText: "Brand",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.barcodeController,
                        decoration: InputDecoration(
                          labelText: "Barcode",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.caloriesController,
                        decoration: InputDecoration(
                          labelText: "Calories",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.proteinController,
                        decoration: InputDecoration(
                          labelText: "Protein (g)",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.fatController,
                        decoration: InputDecoration(
                          labelText: "Fat (g)",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.carbohydratesController,
                        decoration: InputDecoration(
                          labelText: "Carbohydrates (g)",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.servingSizeController,
                        decoration: InputDecoration(
                          labelText: "Serving Size",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.ingredientsController,
                        decoration: InputDecoration(
                          labelText: "Ingredients",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.allergensController,
                        decoration: InputDecoration(
                          labelText: "Allergens",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: controller.dietaryInfoController,
                        decoration: InputDecoration(
                          labelText: "Dietary Information",
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _updateProduct();
                          },
                          child: const Text("Update Product"),
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

  void _updateProduct() {
    controller.updateProduct(product);
  }
}
