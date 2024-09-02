import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';

import '../../../../core/utils/widgets/constants.dart';
import '../../../../core/utils/widgets/reusable_widgets_manager/toast_function.dart';

class FavouriteAndCartIcons extends StatelessWidget {
  const FavouriteAndCartIcons({super.key, required this.product});
  final dynamic product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocConsumer<FavouritesCubit, FavouritesState>(
          listener: (context, state) {
            if (state is ToggleFavoriteErrorState) {
              showToast(
                message: state.error,
                isError: true,
              );
            }
          },
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
        BlocConsumer<ToggleCartCubit, ToggleCartState>(
          listener: (context, state) {
            if (state is ToggleCartItemsErrorState) {
              showToast(
                message: state.error,
                isError: true,
              );
            }
          },
          builder: (context, state) {
            return BlocConsumer<CartsCubit, CartsState>(
              listener: (context, state) {},
              builder: (context, state) {
                final isCart = carts[product.id] ?? false;
                return IconButton(
                  onPressed: () {
                    ToggleCartCubit.get(context).changeCarts(product.id);
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
            );
          },
        ),
      ],
    );
  }
}
