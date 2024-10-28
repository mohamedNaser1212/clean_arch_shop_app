import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/favourites_and_carts_icons/favourites_and_cart_icons_body.dart';
import '../../models/base_products_model.dart';

class ProductsIcons extends StatefulWidget {
  const ProductsIcons({super.key, required this.model});

  final BaseProductModel model;

  @override
  State<ProductsIcons> createState() => _ProductsIconsState();
}

class _ProductsIconsState extends State<ProductsIcons> {
  @override
  Widget build(BuildContext context) {
    return ProductIconsBody(widget: widget);
  }
}
