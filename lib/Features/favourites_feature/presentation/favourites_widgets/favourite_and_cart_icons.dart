import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';

import '../../../../core/utils/screens/widgets/end_points.dart';
import '../../../home/presentation/cubit/shop_cubit/shop_cubit.dart';

class FavouriteAndCartIcons extends StatelessWidget {
  const FavouriteAndCartIcons({super.key, required this.product});
  final dynamic product;

  @override
  Widget build(BuildContext context) {
    final homeCubit = ShopCubit.get(context);

    return Row(
      children: [
        BlocBuilder<FavouritesCubit, FavouritesState>(
          builder: (context, state) {
            final favouritesCubit = FavouritesCubit.get(context);
            final isFavorite = favorites[product.id] ?? false;

            return IconButton(
              onPressed: () {
                favouritesCubit.changeFavourite(product.id);
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
        IconButton(
          onPressed: () {
            homeCubit.changeCarts(product.id);
          },
          icon: CircleAvatar(
            backgroundColor:
                carts[product.id] ?? false ? Colors.red : Colors.grey,
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
