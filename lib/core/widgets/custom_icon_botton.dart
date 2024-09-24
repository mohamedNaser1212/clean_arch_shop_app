import 'package:flutter/material.dart';

import 'package:shop_app/core/utils/styles_manager/color_manager.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, 
    required this.onPressed,
    required this.icon,
    required this.backgroundColor,
    this.iconColor = ColorController.whiteColor,
    this.radius = 15,
    this.iconSize = 15,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double radius;
  final double iconSize;




  factory CustomIconButton.cartButton({
    required bool isCart,
    required VoidCallback onPressed,
  }) {
    return CustomIconButton(
      onPressed: onPressed,
      icon: Icons.shopping_cart,
      backgroundColor: isCart ? ColorController.redColor : ColorController.greyColor,
    );
  }


  factory CustomIconButton.favoriteButton({
    required bool isFavorite,
    required VoidCallback onPressed,
  }) {
    return CustomIconButton(
      onPressed: onPressed,
      icon: Icons.favorite,
      backgroundColor: isFavorite ? ColorController.redColor : ColorController.greyColor,
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
    return CustomIconButton(
      onPressed: onPressed,
      icon: icon,
      backgroundColor: backgroundColor ?? ColorController.blueAccent,
      iconColor: iconColor ?? ColorController.whiteColor,
      radius: radius ?? 15,
      iconSize: iconSize ?? 15,
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
