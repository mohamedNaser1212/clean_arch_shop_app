import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_item_image.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_information_widget.dart';
import 'package:shop_app/core/models/base_products_model.dart';
import 'package:shop_app/core/widgets/products_details_screen.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../favourites_feature/presentation/favourites_widgets/favourite_and_cart_icons.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final BaseProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationManager.navigateTo(
          context: context,
          screen: ProductsDetailsScreen(model: product),
        );
      },
      child: Container(
        color: ColorController.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductItemImage(product: product),
              ProductInformationWidget(product: product),
              FavouriteAndCartIcons(product: product),
            ],
          ),
        ),
      ),
    );
  }
}
