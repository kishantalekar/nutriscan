// import 'package:nutriscan/data/repositories/auth/authentication_repository.dart';
// import 'package:nutriscan/data/repositories/user/user_repository.dart';
import 'dart:developer';

import 'package:nutriscan/data/user/user_repository.dart';
import 'package:nutriscan/features/admin/model/product_model.dart';
import 'package:nutriscan/features/authentication/models/user_model.dart';
import 'package:nutriscan/features/customer/screens/scan/product_details.dart';
import 'package:nutriscan/features/customer/screens/expiry/expiry_tracker.dart';
import 'package:nutriscan/features/customer/screens/scan/home_screen.dart';
// import 'package:nutriscan/features/authentication/screens/login/login.dart';
// import 'package:nutriscan/features/personalization/screens/profile/widgets/re_auth_form.dart';
import 'package:nutriscan/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../admin/controller/admin_controller.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  final Rx<int> selectedIndex = 0.obs;
  final AdminController adminController = Get.put(AdminController());
  final List<Widget> screens = [
    const HomeScreen(),
    const SizedBox.shrink(), // Placeholder for scanner
    const ExpiryTracker(),
  ];

  var scannedItems = <Product>[].obs;

  Future<void> onDestinationSelected(BuildContext context, int index) async {
    selectedIndex.value = index;
    if (index == 1) {
      var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(),
        ),
      );
      res = "6907202691460";
      if (res != null) {
        log(res);
        final exists = await adminController.getProduct(res);
        if (exists != null) {
          if (scannedItems.contains(exists) != false) {
            scannedItems.add(exists);
            scannedItems.refresh();
            await addProductToScannedHistory(res);
          }

          Get.to(() => ProductDetail(
                product: exists,
              ));
        } else {
          // _showProductNotFoundDialog(context);
          TFullScreenLoader.warningSnackBar(title: 'Product doesnt exists');
        }
      }
    }
  }

  Future<void> addProductToScannedHistory(String barcodeId) async {
    try {
      log(user.value.toString());

      final scannedHistory = [...user.value.scannedHistory, barcodeId];
      log("scannedHistory ${scannedHistory}");
      final UserModel updatedUser = user.value.copyWith(
        scannedHistory: scannedHistory,
      );
      log("addProductToScannedHistory");
      log(updatedUser.toString());
      await userRepository.updateUserDetails(updatedUser);
      user.value = updatedUser; // Update the local user model

      log('updateed user ${user.value}');
    } catch (e) {
      TFullScreenLoader.warningSnackBar(
          title: 'Failed to add to history', message: e.toString());
      log(e.toString());
    }
  }

  //save user record
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        final nameParts =
            UserModel.nameParts(userCredential.user!.displayName ?? "");
        final username =
            UserModel.generateUsername(userCredential.user!.displayName ?? "");

        final user = UserModel(
          id: userCredential.user!.uid,
          firstname: nameParts.first,
          lastname: nameParts.length > 1 ? nameParts.sublist(1).join(" ") : '',
          username: username,
          email: userCredential.user?.email ?? " ",
          phoneNumber: userCredential.user?.phoneNumber ?? " ",
          profilePicture: userCredential.user?.photoURL ?? " ",
          scannedHistory: [],
        );

        await userRepository.saveUserData(user);
      }
    } catch (e) {
      TFullScreenLoader.warningSnackBar(
          title: 'Data not saved',
          message: "Something went wrong while saving your info");
    }
  }

  Future<void> fetchUserDetails() async {
    try {
      profileLoading.value = true;
      final data = await userRepository.fetchUserDetails();
      log(data.toString());
      user.value = data;

      await _fetchScannedItemsDetails();
    } catch (e) {
      this.user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> _fetchScannedItemsDetails() async {
    try {
      List<Product> products = [];
      for (var barcode in user.value.scannedHistory) {
        final product = await adminController.getProduct(barcode);
        if (product != null) {
          products.add(product);
        }
      }
      scannedItems.assignAll(products);
    } catch (e) {
      TFullScreenLoader.warningSnackBar(
          title: 'Failed to fetch scanned items', message: e.toString());
      log(e.toString());
    }
  }
}
