import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_item_image.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_information_widget.dart';
import 'package:shop_app/core/models/base_products_model.dart';
import 'package:shop_app/core/widgets/products_details_widgets/products_details_screen.dart';

import '../../../../core/functions/navigations_function.dart';
import '../../../../core/utils/styles/color_manager.dart';
import '../../../../core/widgets/favourites_and_carts_icons/produxts_icons.dart';

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
              ProductItemImage(state: this),
              ProductInformationWidget(model: widget.product),
              ProductsIcons(model: widget.product),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {
    final isProductEntity = widget.product is ProductEntity;
    NavigationFunctions.navigateTo(
      context: context,
      screen: ProductsDetailsScreen(
        model: widget.product,
        isProductEntity: isProductEntity,
      ),
    );
  }
}
