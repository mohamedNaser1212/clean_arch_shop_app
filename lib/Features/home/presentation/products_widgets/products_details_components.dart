import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/description_text_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_description_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_information_body.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_name_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_additional_images.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_prices_widgets.dart';

class ProductsDetailsComponents extends StatelessWidget {
  const ProductsDetailsComponents({super.key, required this.state});
  final ProductDetailsInformationBodyState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductNameWidget(state: state),
        const SizedBox(height: 8),
        const DescriptionTextWidget(),
        const SizedBox(height: 4),
        ProductDescriptionWidget(
          state: state,
        ),
        const SizedBox(height: 8),
        if (state.widget.model.discount != 0)
          ProductsPricesWidgets(state: state),
        const SizedBox(height: 16),
        if (state.widget.isProduct) ProductsAdditionalImages(state: state),
      ],
    );
  }
}
