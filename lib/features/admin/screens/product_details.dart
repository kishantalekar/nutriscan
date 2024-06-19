import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nutriscan/features/admin/model/product_model.dart';
import 'package:nutriscan/features/customer/customer.dart';
import 'package:nutriscan/utils/constants/image_strings.dart';
import 'package:nutriscan/utils/constants/sizes.dart';
import 'package:nutriscan/utils/helpers/helper_functions.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: product.imageUrl.length > 5
                  ? Image.network(
                      product.imageUrl,
                      width: THelperFunctions.screenWidth() * 0.8,
                    )
                  : Image.asset(
                      "assets/images/content/upload_image_placeholder.png",
                      width: THelperFunctions.screenWidth() * 0.5,
                    ),
            ),
            Gap(30),
            _buildDetailRow("Product ID", product.id),
            _buildDetailRow("Product Name", product.name),
            _buildDetailRow("Brand", product.brand),
            _buildDetailRow("Barcode", product.barcode),
            _buildDetailRow("Calories", product.calories.toString()),
            _buildDetailRow("Protein (g)", product.protein.toString()),
            _buildDetailRow("Fat (g)", product.fat.toString()),
            _buildDetailRow(
                "Carbohydrates (g)", product.carbohydrates.toString()),
            _buildDetailRow("Serving Size", product.servingSize),
            _buildDetailRow("Ingredients", product.ingredients),
            _buildDetailRow("Allergens", product.allergens),
            _buildDetailRow("Dietary Information", product.dietaryInfo),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 7,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
