import 'package:nutriscan/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:nutriscan/common/widgets/image/circular_image.dart';
import 'package:nutriscan/common/widgets/texts/brand_title_text_with_verification.dart';
import 'package:nutriscan/utils/constants/colors.dart';
import 'package:nutriscan/utils/constants/enums.dart';
import 'package:nutriscan/utils/constants/image_strings.dart';
import 'package:nutriscan/utils/constants/sizes.dart';
import 'package:nutriscan/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
  });

  final bool showBorder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            //Icon
            Flexible(
              child: TCircularImage(
                isNetworkImage: false,
                backgroundColor: Colors.transparent,
                overlayColor: THelperFunctions.isDarkMode(context)
                    ? TColors.white
                    : TColors.black,
                image: TImages.clothIcon,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            //text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TBrandTitleTextWithVerification(
                    title: "Nike",
                    brandTextSizes: TextSizes.large,
                  ),
                  Text(
                    '256 products.',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
