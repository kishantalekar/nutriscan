import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutriscan/features/customer/controller/expiry_controller.dart';
import 'package:nutriscan/features/customer/model/food_item_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _quantityController = TextEditingController();
  File? _pickedImage;
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickImage() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImageFile == null) {
      return;
    }
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(pickedImageFile.path);
    final savedImage =
        await File(pickedImageFile.path).copy('${appDir.path}/$fileName');
    setState(() {
      _pickedImage = savedImage;
    });
  }

  void _submitData() {
    if (_nameController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _pickedImage == null) {
      return;
    }

    final enteredName = _nameController.text;
    final enteredCategory = _categoryController.text;
    final enteredQuantity = int.tryParse(_quantityController.text);

    if (enteredQuantity == null || enteredQuantity <= 0) {
      return;
    }

    final foodController = Get.find<FoodController>();
    foodController.addItem(FoodItem(
      name: enteredName,
      category: enteredCategory,
      expiryDate: _selectedDate,
      quantity: enteredQuantity,
      photoPath: _pickedImage!.path,
    ));

    Get.back();
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: _nameController,
                ),
                Gap(10),
                TextField(
                  decoration: InputDecoration(labelText: 'Category'),
                  controller: _categoryController,
                ),
                Gap(10),
                TextField(
                  decoration: InputDecoration(labelText: 'Quantity'),
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                ),
                Gap(10),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Expiry Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                      ),
                    ),
                    TextButton(
                      onPressed: () => _presentDatePicker(context),
                      child: Text('Choose Date'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: _pickedImage != null
                      ? Image.file(
                          _pickedImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Text(
                          'No Image Taken',
                          textAlign: TextAlign.center,
                        ),
                  alignment: Alignment.center,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      icon: Icon(Icons.camera),
                      label: Text('Take Picture'),
                      onPressed: _pickImage,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Add Item'),
                  ),
                  onPressed: _submitData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
