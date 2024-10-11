import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_icon_widget.dart';
import 'package:shop_app/Features/favourites_feature/presentation/favourites_widgets/favorite_icon_widget.dart';
import 'package:shop_app/core/widgets/favourites_and_carts_icons/produxts_icons.dart';

class FavouriteAndCartIconsBody extends StatelessWidget {
  const FavouriteAndCartIconsBody({
    super.key,
    required this.widget,
  });

  final ProductsIcons widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FavoriteIconWidget(
          product: widget.model,
        ),
        CartIconWidget(
          product: widget.model,
        ),
      ],
    );
  }
}
