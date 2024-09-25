import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_item_image.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_information_widget.dart';
import 'package:shop_app/core/models/base_products_model.dart';
import 'package:shop_app/core/widgets/products_details_screen.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/favourite_and_cart_icons.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final BaseProductModel product;

  @override
  State<ProductItem> createState() => ProductItemState();
}

class ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        color: ColorController.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductItemImage(product: this),
              ProductInformationWidget(model: widget.product),
              FavouriteAndCartIcons(model: widget.product),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {
    NavigationManager.navigateTo(
      context: context,
      screen: ProductsDetailsScreen(model: widget.product),
    );
  }
}
