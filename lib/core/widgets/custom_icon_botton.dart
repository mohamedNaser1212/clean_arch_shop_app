import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_icon_widget.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/toggle_favourite_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/favourites_widgets/favorite_icon_widget.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton._({
    required this.onPressed,
    required this.icon,
    required this.backgroundColor,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor = ColorController.whiteColor;
  final double radius = 15;
  final double iconSize = 15;

  factory CustomIconButton.cartButton({
    required CartIconWidgetState state,
    required bool isCart,
    required BuildContext context,
  }) {
    return CustomIconButton._(
      onPressed: () async {
        final cartsCubit = CartsCubit.get(context);
        final isCart = cartsCubit.carts[state.widget.product.id] ?? false;
        cartsCubit.carts[state.widget.product.id] = !isCart;
        ToggleCartCubit.get(context).changeCarts(state.widget.product.id);
      },
      icon: Icons.shopping_cart,
      backgroundColor:
          isCart ? ColorController.redColor : ColorController.greyColor,
    );
  }

  factory CustomIconButton.favoriteButton({
    required bool isFavorite,
    required BuildContext context,
    required FavoriteIconWidgetState state,
  }) {
    return CustomIconButton._(
      onPressed: () {
        final favouritesCubit = FavouritesCubit.get(context);

        final isFavorite =
            favouritesCubit.favorites[state.widget.product.id] ?? false;
        favouritesCubit.favorites[state.widget.product.id] = !isFavorite;
        ToggleFavouriteCubit.get(context)
            .changeFavourite(state.widget.product.id);
      },
      icon: Icons.favorite,
      backgroundColor:
          isFavorite ? ColorController.redColor : ColorController.greyColor,
    );
  }

  factory CustomIconButton.custom({
    required IconData icon,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? iconColor,
    double? radius,
    double? iconSize,
  }) {
    return CustomIconButton._(
      onPressed: onPressed,
      icon: icon,
      backgroundColor: backgroundColor ?? ColorController.blueAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: radius,
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
