import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

class EmptyProductsTextWidget extends StatelessWidget {
  const EmptyProductsTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomTitle(
      title: 'No products available',
      style: TitleStyle.style16,
    );
  }
}
