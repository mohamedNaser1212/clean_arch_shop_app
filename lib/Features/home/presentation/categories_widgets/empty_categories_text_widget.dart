import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

class EmptyCategoriesTextWidget extends StatelessWidget {
  const EmptyCategoriesTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomTitle(
      title: 'No categories available',
      style: TitleStyle.style16,
    );
  }
}
