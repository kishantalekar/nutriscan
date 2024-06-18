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
            if (product.imageUrl != null)
              Center(
                child: Image.network(
                  product.imageUrl!,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text(
              product.name,
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text(
              'Brand: ${product.brand}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text(
              'Barcode: ${product.barcode}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text(
              'Nutritional Information',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Text(
              'Calories: ${product.calories}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'Protein: ${product.protein} g',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'Fat: ${product.fat} g',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'Carbohydrates: ${product.carbohydrates} g',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text(
              'Serving Size',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Text(
              product.servingSize,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Text(
              product.ingredients,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text(
              'Allergens',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Text(
              product.allergens,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Text(
              'Dietary Information',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Text(
              product.dietaryInfo,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
