import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

class EmptyCartTextWidget extends StatelessWidget {
  const EmptyCartTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomTitle(
        title: 'Sorry, there are no items in your cart',
        style: TitleStyle.style20,
        color: ColorController.blackColor,
      ),
    );
  }
}