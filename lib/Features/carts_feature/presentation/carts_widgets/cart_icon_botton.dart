
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';

class CartIconBotton extends StatelessWidget {
  const CartIconBotton({super.key, required this.isCart, required this.onPressed});

final bool isCart;
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed:onPressed ,
        icon: CircleAvatar(
          backgroundColor:
              isCart ? ColorController.redColor : ColorController.greyColor,
          radius: 15,
          child: const Icon(
            Icons.shopping_cart,
            size: 15,
            color: ColorController.whiteColor,
          ),
        ),
      );
  }
}