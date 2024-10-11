import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_information_body.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';
import 'package:shop_app/core/models/base_products_model.dart';

class ProductsPricesWidgets extends StatelessWidget {
  const ProductsPricesWidgets({super.key, this.model, this.state});

  final BaseProductModel? model;
  final ProductDetailsInformationBodyState? state;

  @override
  Widget build(BuildContext context) {
    final productModel = model ?? state?.widget.model;

    return Column(
      children: [
        if (model != null && model!.discount != 0)
          CustomTitle(
            title: 'Discount: ${productModel!.discount}%',
            style: TitleStyle.style18,
            color: ColorController.redAccent,
          ),
        if (productModel!.discount != 0 && model != null)
          CustomTitle(
            title: 'Old Price: ${productModel.oldPrice}',
            style: TitleStyle.style18,
            color: ColorController.accentColor,
          ),
        if (model != null)
          CustomTitle(
            title: 'Price: ${productModel.price}',
            style: TitleStyle.style20,
            color: ColorController.blackColor,
          ),
      ],
    );
  }
}
