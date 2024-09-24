import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/toggle_favourite_cubit.dart';
import 'package:shop_app/core/functions/dialogue_function.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/models/base_products_model.dart';

import 'package:shop_app/core/widgets/custom_icon_botton.dart';


class FavoriteIconWidget extends StatefulWidget {
  const FavoriteIconWidget({super.key, required this.product});
  final BaseProductModel product;

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  int favouriteClickCount = 0;
  final int maxClickCount = 2;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToggleFavouriteCubit, ToggleFavouriteState>(
      listener: _toggleFavouriteListener,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, ToggleFavouriteState state) {
    final isFavorite =
        FavouritesCubit.get(context).favorites[widget.product.id] ?? false;

    return CustomIconButton.favoriteButton(
      isFavorite: isFavorite,
      onPressed: () => _onFavouritePressed(context, widget.product.id),
    );
  }

  void _toggleFavouriteListener(
      BuildContext context, ToggleFavouriteState state) {
    if (state is ToggleFavoriteErrorState) {
      FavouritesCubit.get(context).favorites[widget.product.id] =
          !(FavouritesCubit.get(context).favorites[widget.product.id] ?? false);
      showToast(message: state.error);
    }
  }

  void _onFavouritePressed(BuildContext context, num productId) {
    final favouritesCubit = FavouritesCubit.get(context);

    if (favouriteClickCount >= maxClickCount) {
      showLimitDialog(
        context: context,
        text: "Favourite",
        maxClickCount: maxClickCount,
      );
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
}
