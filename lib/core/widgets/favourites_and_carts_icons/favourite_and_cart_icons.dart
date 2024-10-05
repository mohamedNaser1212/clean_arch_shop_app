import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/favourites_and_carts_icons/favourites_and_cart_icons_body.dart';
import '../../models/base_products_model.dart';

class FavouriteAndCartIcons extends StatefulWidget {
  const FavouriteAndCartIcons({super.key, required this.model});

  final BaseProductModel model;

  @override
  State<FavouriteAndCartIcons> createState() => _FavouriteAndCartIconsState();
}

class _FavouriteAndCartIconsState extends State<FavouriteAndCartIcons> {
  @override
  Widget build(BuildContext context) {
    return FavouriteAndCartIconsBody(widget: widget);
  }
}
