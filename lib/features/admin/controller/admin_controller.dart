import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutriscan/data/product/product_repository.dart';
import 'package:nutriscan/features/admin/model/product_model.dart';
import 'package:nutriscan/utils/constants/image_strings.dart';
import 'package:nutriscan/utils/popups/loaders.dart';

class AdminController extends GetxController {
  static AdminController get instance => Get.find();
  final ProductRepository productRepository = Get.put(ProductRepository());

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController carbohydratesController = TextEditingController();
  final TextEditingController servingSizeController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController allergensController = TextEditingController();
  final TextEditingController dietaryInfoController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final Rx<File?> imageFile = Rx<File?>(null);
  Future<void> selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      update(); // Update the state to reflect the selected image
    }
  }

  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllProducts(); // Fetch all products when the controller is initialized
  }

  Future<void> addProduct() async {
    try {
      print(barcodeController.text);
      TFullScreenLoader.openLoadingPage(
          "Adding product", TImages.dockerAnimation);
      Product product = Product(
        id: barcodeController.text,
        name: nameController.text,
        brand: brandController.text,
        barcode: barcodeController.text,
        calories: int.parse(caloriesController.text),
        protein: double.parse(proteinController.text),
        fat: double.parse(fatController.text),
        carbohydrates: double.parse(carbohydratesController.text),
        servingSize: servingSizeController.text,
        ingredients: ingredientsController.text,
        allergens: allergensController.text,
        dietaryInfo: dietaryInfoController.text,
        imageUrl: imageFile.value != null
            ? await productRepository.uploadImage(imageFile.value!)
            : "",
      );
      await productRepository.addProduct(product);

      products.add(product); // Update the local list

      TFullScreenLoader.stopLoading();
      Get.back();
      TFullScreenLoader.successSnackBar(
          title: 'Success ', message: "Product added successfully");

      idController.clear();
      nameController.clear();
      brandController.clear();
      barcodeController.clear();
      caloriesController.clear();
      proteinController.clear();
      fatController.clear();
      carbohydratesController.clear();
      servingSizeController.clear();
      ingredientsController.clear();
      allergensController.clear();
      dietaryInfoController.clear();
      imageFile.value = null;
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(title: "oh snap", message: e.toString());
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      TFullScreenLoader.openLoadingPage(
          "Updating product", TImages.dockerAnimation);
      Product updatedProduct = Product(
          id: idController.text,
          name: nameController.text,
          brand: brandController.text,
          barcode: barcodeController.text,
          calories: int.parse(caloriesController.text),
          protein: double.parse(proteinController.text),
          fat: double.parse(fatController.text),
          carbohydrates: double.parse(carbohydratesController.text),
          servingSize: servingSizeController.text,
          ingredients: ingredientsController.text,
          allergens: allergensController.text,
          dietaryInfo: dietaryInfoController.text,
          imageUrl: imageFile.value != null
              ? await productRepository.uploadImage(imageFile.value!)
              : product.imageUrl);

      await productRepository.updateProduct(updatedProduct);

      // Update the local list
      int index = products.indexWhere((p) => p.id == updatedProduct.id);
      if (index != -1) {
        products[index] = updatedProduct;
      }

      TFullScreenLoader.stopLoading();
      Get.back();
      TFullScreenLoader.successSnackBar(
          title: 'Success ', message: "Product updated successfully");
      idController.clear();
      nameController.clear();
      brandController.clear();
      barcodeController.clear();
      caloriesController.clear();
      proteinController.clear();
      fatController.clear();
      carbohydratesController.clear();
      servingSizeController.clear();
      ingredientsController.clear();
      allergensController.clear();
      dietaryInfoController.clear();
      imageFile.value = null;
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(title: "oh snap", message: e.toString());
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      TFullScreenLoader.openLoadingPage(
          "Deleting product", TImages.dockerAnimation);
      await productRepository.deleteProduct(id);

      // Update the local list
      products.removeWhere((p) => p.id == id);

      TFullScreenLoader.stopLoading();
      TFullScreenLoader.successSnackBar(
          title: 'Success ', message: "Product deleted successfully");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnackBar(title: "oh snap", message: e.toString());
    }
  }

  Future<Product?> getProduct(String id) async {
    try {
      return await productRepository.getProduct(id);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch product: $e");
      return null;
    }
  }

  Future<void> getAllProducts() async {
    try {
      final data = await productRepository.getAllProducts();
      print(data);
      products.value = data;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch products: $e");
    }
  }
}
