import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_information_body.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class ProductDescriptionWidget extends StatelessWidget {
  const ProductDescriptionWidget({super.key, required this.state});
  final ProductDetailsInformationBodyState state;
  @override
  Widget build(BuildContext context) {
    return CustomTitle(
      title: state.widget.model.description,
      style: TitleStyle.style16,
      color: ColorController.accentColor,
    );
  }
}
