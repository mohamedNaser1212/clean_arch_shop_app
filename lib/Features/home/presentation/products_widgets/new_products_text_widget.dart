
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class NewProductsTextWidget extends StatelessWidget {
  const NewProductsTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomTitle(
      title: 'New Products',
      style: TitleStyle.style24,
      color: ColorController.blackColor,
    );
  }
}