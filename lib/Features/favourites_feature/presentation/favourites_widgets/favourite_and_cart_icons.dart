import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_icon_widget.dart';

import 'package:shop_app/Features/favourites_feature/presentation/favourites_widgets/favorite_icon_widget.dart';

import '../../../../core/models/base_products_model.dart';

class FavouriteAndCartIcons extends StatefulWidget {
  const FavouriteAndCartIcons({super.key, required this.model});

   final BaseProductModel model;

  @override
  State<FavouriteAndCartIcons> createState() => _FavouriteAndCartIconsState();
}

class _FavouriteAndCartIconsState extends State<FavouriteAndCartIcons> {
  int favouriteClickCount = 0;
  int cartClickCount = 0;
  final int maxClickCount = 2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FavoriteIconWidget(
          product: widget.model, 
        ),
        CartIconWidget(
          product:  widget.model ,
        ),
      ],
    );
  }
}
