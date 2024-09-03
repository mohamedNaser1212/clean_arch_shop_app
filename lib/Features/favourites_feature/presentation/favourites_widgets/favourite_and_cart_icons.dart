import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/toggle_favourite_cubit.dart';

import '../../../../core/models/base_products_model.dart';
import '../../../../core/utils/widgets/constants.dart';
import '../../../../core/utils/widgets/reusable_widgets_manager/toast_function.dart';

class FavouriteAndCartIcons extends StatelessWidget {
  const FavouriteAndCartIcons({super.key, required this.product});

  final BaseProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildFavouriteIcon(context),
        buildCartIcon(context),
      ],
    );
  }

  // Method to build the Favourite Icon with Bloc Consumers
  Widget buildFavouriteIcon(BuildContext context) {
    return BlocConsumer<ToggleFavouriteCubit, ToggleFavouriteState>(
      listener: (context, state) => toggleFavouriteListener(context, state),
      builder: (context, state) =>
          BlocConsumer<FavouritesCubit, FavouritesState>(
        listener: (context, state) => favouritesListener(context, state),
        builder: (context, state) {
          final isFavorite =
              FavouritesCubit.get(context).favorites[product.id] ?? false;
          return IconButton(
            onPressed: () => onFavouritePressed(context),
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
    );
  }

  // Listener for the ToggleFavouriteCubit
  void toggleFavouriteListener(
      BuildContext context, ToggleFavouriteState state) {
    if (state is ToggleFavoriteErrorState) {
      showToast(
        message: state.error,
        isError: true,
      );
    } else if (state is ToggleFavouriteSuccessState) {
      FavouritesCubit.get(context).getFavorites();
    }
  }

  // Listener for the FavouritesCubit
  void favouritesListener(BuildContext context, FavouritesState state) {
    if (state is ShopGetFavoritesErrorState) {
      FavouritesCubit.get(context).favorites[product.id] =
          !(FavouritesCubit.get(context).favorites[product.id] ?? false);
      showToast(
        message: state.error,
        isError: true,
      );
    }
  }

  // Favourite button press handler
  void onFavouritePressed(BuildContext context) {
    FavouritesCubit.get(context).favorites[product.id] =
        !(FavouritesCubit.get(context).favorites[product.id] ?? false);
    ToggleFavouriteCubit.get(context).changeFavourite(product.id);
  }

  Widget buildCartIcon(BuildContext context) {
    return BlocConsumer<ToggleCartCubit, ToggleCartState>(
      listener: (context, state) => toggleCartListener(context, state),
      builder: (context, state) => BlocConsumer<CartsCubit, CartsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final isCart = carts[product.id] ?? false;
          return IconButton(
            onPressed: () => onCartPressed(context),
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
    );
  }

  // Listener for the ToggleCartCubit
  void toggleCartListener(BuildContext context, ToggleCartState state) {
    if (state is ToggleCartItemsErrorState) {
      showToast(
        message: state.error,
        isError: true,
      );
    }
  }

  // Cart button press handler
  void onCartPressed(BuildContext context) {
    ToggleCartCubit.get(context).changeCarts(product.id);
  }
}
