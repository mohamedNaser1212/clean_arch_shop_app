import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/toggle_favourite_cubit.dart';

import '../../../../core/functions/toast_function.dart';
import '../favourites_widgets/favourites_screen_body.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToggleCartCubit, ToggleCartState>(
      listener: _toggleCartListener,
      builder: (context, cartState) {
        return BlocConsumer<ToggleFavouriteCubit, ToggleFavouriteState>(
          listener: _toggleFavouriteListener,
          builder: (context, favState) {
            return BlocBuilder<FavouritesCubit, FavouritesState>(
              builder: (context, state) {
                return FavoritesScreenBody(
                  state: state,
                );
              },
            );
          },
        );
      },
    );
  }

  void _toggleCartListener(BuildContext context, ToggleCartState state) {
    if (state is ToggleCartSuccessState) {
      FavouritesCubit.get(context).getFavorites();
    }
  }

  void _toggleFavouriteListener(
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
}
