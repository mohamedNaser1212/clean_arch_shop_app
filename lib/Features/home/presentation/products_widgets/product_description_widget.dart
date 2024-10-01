import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_body.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class ProductDescriptionWidget extends StatelessWidget {
  const ProductDescriptionWidget({super.key, required this.state});
  final ProductDetailsBodyState state;
  @override
  Widget build(BuildContext context) {
    return CustomTitle(
      title: state.widget.model.description,
      style: TitleStyle.style16,
      color: ColorController.accentColor,
    );
  }
}
