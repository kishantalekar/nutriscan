import 'package:flutter/material.dart';
import 'package:nutriscan/features/admin/model/product_model.dart';
import 'package:nutriscan/utils/constants/sizes.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imageUrl.isNotEmpty)
              Center(
                child: Image.network(
                  product.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: TSizes.spaceBtwSections),
            buildSectionTitle(context, 'Product Information'),
            buildInfoCard('Brand', product.brand),
            buildInfoCard('Barcode', product.barcode),
            buildSectionTitle(context, 'Nutritional Information'),
            buildNutritionalInfo(context),
            buildSectionTitle(context, 'Serving Size'),
            buildInfoCard('', product.servingSize),
            buildSectionTitle(context, 'Ingredients'),
            buildInfoCard('', product.ingredients),
            buildSectionTitle(context, 'Allergens'),
            buildInfoCard('', product.allergens),
            buildSectionTitle(context, 'Dietary Information'),
            buildInfoCard('', product.dietaryInfo),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildNutritionalInfo(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildNutritionalRow('Calories', '${product.calories} kcal'),
            const Divider(),
            buildNutritionalRow('Protein', '${product.protein} g'),
            const Divider(),
            buildNutritionalRow('Fat', '${product.fat} g'),
            const Divider(),
            buildNutritionalRow('Carbohydrates', '${product.carbohydrates} g'),
          ],
        ),
      ),
    );
  }

  Widget buildNutritionalRow(String nutrient, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(nutrient, style: const TextStyle(fontSize: 16)),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget buildInfoCard(String title, String detail) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      child: ListTile(
        title: Text(detail, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
