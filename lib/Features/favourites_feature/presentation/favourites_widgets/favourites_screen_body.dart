import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/get_carts_cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_carts_cubit/toggle_cart_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/toggle_favourites_cubit/toggle_favourite_cubit.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/widgets/custom_refresh_indicator.dart';

class FavoritesScreenBody extends StatelessWidget {
  const FavoritesScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToggleCartCubit, ToggleCartState>(
      listener: _toggleCartListener,
      builder: (context, cartState) {
        return BlocConsumer<ToggleFavouriteCubit, ToggleFavouriteState>(
          listener: _toggleFavouriteListener,
          builder: _toggleFaavouritesBuilder,
        );
      },
    );
  }

  Widget _toggleFaavouritesBuilder(context, favState) {
    return BlocBuilder<FavouritesCubit, FavouritesState>(
      builder: _favoritesScreenBuilder,
    );
  }

  Widget _favoritesScreenBuilder(context, state) {
    return CustomRefreshIndicator.favorites(context: context);
  }

  void _toggleCartListener(BuildContext context, ToggleCartState state) {
    if (state is ToggleCartSuccessState) {
      CartsCubit.get(context).getCarts();
    }
  }

  void _toggleFavouriteListener(
      BuildContext context, ToggleFavouriteState state) {
    if (state is ToggleFavoriteErrorState) {
      ToastHelper.showToast(
        message: state.error,
      );
    }
  }
}

//   }
// }
