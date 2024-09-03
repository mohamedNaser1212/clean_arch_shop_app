import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/toggle_favourite_cubit.dart';

import '../../../../core/models/base_products_model.dart';
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

  Widget buildFavouriteIcon(BuildContext context) {
    return BlocConsumer<ToggleFavouriteCubit, ToggleFavouriteState>(
      listener: toggleFavouriteListener,
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
    );
  }

  void toggleFavouriteListener(
      BuildContext context, ToggleFavouriteState state) {
    if (state is ToggleFavoriteErrorState) {
      showToast(message: state.error, isError: true);
    } else if (state is ToggleFavouriteSuccessState) {
      FavouritesCubit.get(context).getFavorites();
    }
  }

  void onFavouritePressed(BuildContext context) {
    final favouritesCubit = FavouritesCubit.get(context);
    final isFavorite = favouritesCubit.favorites[product.id] ?? false;
    favouritesCubit.favorites[product.id] = !isFavorite;
    ToggleFavouriteCubit.get(context).changeFavourite(product.id);
  }

  Widget buildCartIcon(BuildContext context) {
    return BlocConsumer<ToggleCartCubit, ToggleCartState>(
      listener: toggleCartListener,
      builder: (context, state) {
        final isCart = CartsCubit.get(context).carts[product.id] ?? false;
        return IconButton(
          onPressed: () => onCartPressed(context, product.id),
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
  }

  void toggleCartListener(BuildContext context, ToggleCartState state) {
    if (state is ToggleCartItemsErrorState) {
      showToast(message: state.error, isError: true);
    } else if (state is ToggleCartSuccessState) {
      CartsCubit.get(context).getCartItems();
    }
  }

  void onCartPressed(BuildContext context, num productId) {
    final cartsCubit = CartsCubit.get(context);
    final isCart = cartsCubit.carts[productId] ?? false;
    cartsCubit.carts[productId] = !isCart;
    ToggleCartCubit.get(context).changeCarts(productId);
  }
}
