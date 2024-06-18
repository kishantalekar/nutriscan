import 'package:flutter/widgets.dart';
import 'package:nutriscan/utils/constants/image_strings.dart';
import 'package:nutriscan/utils/constants/sizes.dart';
import 'package:nutriscan/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image(
              image: AssetImage("assets/images/content/nutriscan.png"),
              height: 150,
            ),
          ),
        ),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        // Text(
        //   TTexts.loginSubTitle,
        //   style: Theme.of(context).textTheme.bodyMedium,
        // )
      ],
    );
  }
}
