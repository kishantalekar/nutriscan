import 'dart:developer';

import 'package:get/get.dart';
import 'package:nutriscan/features/customer/model/food_item_model.dart';
import 'package:nutriscan/utils/helpers/db_helper.dart';
import 'package:nutriscan/utils/helpers/notification_helper.dart';
import 'package:nutriscan/utils/popups/loaders.dart';

class FoodController extends GetxController {
  var foodItems = <FoodItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFoodItems();
  }

  void addItem(FoodItem item) async {
    try {
      int itemId = await DBHelper().insertFoodItem(item);
      item.id = itemId;

      foodItems.add(item);

      final notificationDate = item.expiryDate.subtract(Duration(days: 1));
      await NotificationHelper.showNotification(
        id: item.id!,
        title: 'Item Expiry Reminder',
        body: 'The item "${item.name}" is about to expire tomorrow!',
        scheduledDate: notificationDate,
      );
    } catch (e) {
      print(e);
      TFullScreenLoader.errorSnackBar(title: e.toString());
    }
  }

  void removeItem(FoodItem item) async {
    await DBHelper().deleteFoodItem(item.id!);
    foodItems.remove(item);
  }

  void loadFoodItems() async {
    try {
      final items = await DBHelper().getFoodItems();
      foodItems.assignAll(items);
    } catch (e) {
      print(e);
    }
  }
}
