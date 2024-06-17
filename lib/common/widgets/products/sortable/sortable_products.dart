// import 'package:nutriscan/common/widgets/layouts/grid_layout.dart';
// import 'package:nutriscan/common/widgets/products/product_cards/product_card_vertical.dart';
// import 'package:nutriscan/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class TSortableProducts extends StatelessWidget {
//   const TSortableProducts({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       DropdownButtonFormField(
//           decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
//           items: [
//             "Name",
//             "Higher price",
//             "Lower price",
//             "Sale",
//             "Newest",
//             "Popluarity"
//           ]
//               .map((option) =>
//                   DropdownMenuItem(value: option, child: Text(option)))
//               .toList(),
//           onChanged: (value) {}),
//       const SizedBox(
//         height: TSizes.spaceBtwSections,
//       ),
//       TGridLayout(
//           itemCount: 6,
//           itemBuilder: (context, index) => const ProductCardVertical())
//     ]);
//   }
// }
