import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/description_text_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_description_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_name_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_prices_widgets.dart';
import 'package:shop_app/core/models/base_products_model.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';

class ProductDetailsInformationBody extends StatefulWidget {
  const ProductDetailsInformationBody({
    super.key,
    required this.model,
    required this.images,
  });
  final BaseProductModel model;

  final List<String> images;

  @override
  State<ProductDetailsInformationBody> createState() =>
      ProductDetailsInformationBodyState();
}

class ProductDetailsInformationBodyState
    extends State<ProductDetailsInformationBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorController.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorController.greyColor.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductNameWidget(state: this),
          const SizedBox(height: 8),
          const DescriptionTextWidget(),
          const SizedBox(height: 4),
          ProductDescriptionWidget(
            state: this,
          ),
          const SizedBox(height: 8),
          if (widget.model.discount != 0) ProductsPricesWidgets(state: this),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
