import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/toggle_favourite_cubit.dart';

import '../../../../core/functions/toast_function.dart';
import '../../../../core/models/base_products_model.dart';

class FavouriteAndCartIcons extends StatefulWidget {
  const FavouriteAndCartIcons({super.key, required this.product});

  final BaseProductModel product;

  @override
  State<FavouriteAndCartIcons> createState() => _FavouriteAndCartIconsState();
}

class _FavouriteAndCartIconsState extends State<FavouriteAndCartIcons> {
  int favouriteClickCount = 0;
  int cartClickCount = 0;
  final int maxClickCount = 5;

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
            FavouritesCubit.get(context).favorites[widget.product.id] ?? false;
        return IconButton(
          onPressed: () => onFavouritePressed(context, widget.product.id),
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
      FavouritesCubit.get(context).favorites[widget.product.id] =
          !(FavouritesCubit.get(context).favorites[widget.product.id] ?? false);
      showToast(message: state.error, isError: true);
    }
  }

  void onFavouritePressed(BuildContext context, num productId) {
    final favouritesCubit = FavouritesCubit.get(context);

    if (favouriteClickCount >= maxClickCount) {
      showLimitDialog(context, "Favorites");
      setState(() {
        favouriteClickCount = 0;
      });

      favouritesCubit.favorites[widget.product.id] =
          !(favouritesCubit.favorites[widget.product.id] ?? false);
      return;
    }

    favouriteClickCount++;

    final isFavorite = favouritesCubit.favorites[productId] ?? false;
    favouritesCubit.favorites[productId] = !isFavorite;
    ToggleFavouriteCubit.get(context).changeFavourite(productId);
  }

  Widget buildCartIcon(BuildContext context) {
    return BlocConsumer<ToggleCartCubit, ToggleCartState>(
      listener: toggleCartListener,
      builder: (context, state) {
        final isCart =
            CartsCubit.get(context).carts[widget.product.id] ?? false;
        return IconButton(
          onPressed: () => onCartPressed(context, widget.product.id),
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
      CartsCubit.get(context).carts[widget.product.id] =
          !(CartsCubit.get(context).carts[widget.product.id] ?? false);
      showToast(message: state.error, isError: true);
    }
  }

  void onCartPressed(BuildContext context, num productId) {
    if (cartClickCount >= maxClickCount) {
      showLimitDialog(context, "Cart");
      setState(() {
        cartClickCount = 0;
      });

      CartsCubit.get(context).carts[widget.product.id] =
          !(CartsCubit.get(context).carts[widget.product.id] ?? false);
      return;
    }

    cartClickCount++;
    final cartsCubit = CartsCubit.get(context);
    final isCart = cartsCubit.carts[productId] ?? false;
    cartsCubit.carts[productId] = !isCart;
    ToggleCartCubit.get(context).changeCarts(productId);
  }

  void showLimitDialog(BuildContext context, String actionType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Limit Exceeded"),
        content: Text(
            "You can't use the $actionType action more than $maxClickCount times."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
