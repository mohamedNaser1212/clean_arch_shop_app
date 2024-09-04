import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/toggle_favourite_cubit.dart';

import '../../../../core/functions/toast_function.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../favourites_widgets/favourite_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToggleCartCubit, ToggleCartState>(
      listener: (context, state) {
        if (state is ToggleCartSuccessState) {
          FavouritesCubit.get(context).getFavorites();
        }
      },
      builder: (context, state) {
        return BlocConsumer<ToggleFavouriteCubit, ToggleFavouriteState>(
          listener: (context, state) {
            if (state is ToggleFavoriteErrorState) {
              showToast(
                message: state.error,
                isError: true,
              );
            } else if (state is ToggleFavouriteSuccessState) {
              FavouritesCubit.get(context).getFavorites();
            }
          },
          builder: (context, state) {
            return BlocConsumer<FavouritesCubit, FavouritesState>(
              listener: (context, state) {},
              builder: (context, state) {
                return FavoritesScreenContent(state: state);
              },
            );
          },
        );
      },
    );
  }
}

class FavoritesScreenContent extends StatelessWidget {
  final FavouritesState state;

  const FavoritesScreenContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    var favouritesModel = FavouritesCubit.get(context).getFavouritesModel;

    if (favouritesModel.isEmpty) {
      return const Center(
          child: CustomTitle(
        title: 'Sorry, there are no favourites to show',
        style: TitleStyle.style16,
        color: ColorController.blackColor,
      ));
    }

    return ConditionalBuilder(
      condition: true,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) =>
            FavoriteItem(model: favouritesModel[index]),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: favouritesModel.length,
      ),
      fallback: (context) => Center(
        child: LoadingAnimationWidget.waveDots(color: Colors.grey, size: 90),
      ),
    );
  }
}
