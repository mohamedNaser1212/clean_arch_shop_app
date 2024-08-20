import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';

class FavouriteAndCartIcons extends StatelessWidget {
  const FavouriteAndCartIcons({super.key, required this.product});
  final dynamic product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<FavouritesCubit, FavouritesState>(
          builder: (context, state) {
            final isFavorite =
                FavouritesCubit.get(context).favorites[product.id] ?? false;
            return IconButton(
              onPressed: () {
                FavouritesCubit.get(context).changeFavourite(product.id);
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
            );
          },
        ),
        BlocBuilder<CartsCubit, CartsState>(
          builder: (context, state) {
            final isCart = CartsCubit.get(context).carts[product.id] ?? false;
            return IconButton(
              onPressed: () {
                CartsCubit.get(context).changeCarts(product.id);
              },
              icon: CircleAvatar(
                backgroundColor: isCart ? Colors.red : Colors.grey,
                radius: 15,
                child: const Icon(
                  Icons.shopping_cart,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
