import 'package:flutter/material.dart';

import '../../../../core/widgets/end_points.dart';
import '../../../home/presentation/cubit/shop_cubit/shop_cubit.dart';

class FavouriteAndCartIcons extends StatelessWidget {
  const FavouriteAndCartIcons({super.key, required this.product});
  final dynamic product;
  @override
  Widget build(BuildContext context) {
    final cubit = ShopCubit.get(context);
    final isFavorite = favorites[product.id] ?? false;
    final isInCart = carts[product.id] ?? false;
    return Row(
      children: [
        IconButton(
          onPressed: () {
            cubit.changeFavourite(product.id);
          },
          icon: CircleAvatar(
            backgroundColor: isFavorite ? Colors.red : Colors.grey,
            radius: 15,
            child: const Icon(
              Icons.favorite,
              size: 15,
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            cubit.changeCarts(product.id);
          },
          icon: CircleAvatar(
            backgroundColor: isInCart ? Colors.red : Colors.grey,
            radius: 15,
            child: const Icon(
              Icons.shopping_cart,
              size: 15,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
