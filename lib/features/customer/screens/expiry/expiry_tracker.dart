import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriscan/features/customer/controller/expiry_controller.dart';
import 'package:nutriscan/features/customer/screens/expiry/add_item_screen.dart';

void main() {
  runApp(ExpiryTrackerApp());
}

class ExpiryTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expiry Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ExpiryTracker(),
    );
  }
}

class ExpiryTracker extends StatelessWidget {
  const ExpiryTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final foodController = Get.put(FoodController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Expiry"),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: foodController.foodItems.length,
          itemBuilder: (ctx, index) {
            final item = foodController.foodItems[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Image.file(File(item.photoPath),
                    width: 50, height: 50, fit: BoxFit.cover),
                title: Text(item.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Category: ${item.category}'),
                    Text('Quantity: ${item.quantity}'),
                    Text(
                        'Expires on: ${item.expiryDate.toLocal().toString().split(' ')[0]}'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    foodController.removeItem(item);
                  },
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddItemScreen());
        },
      ),
    );
  }
}
