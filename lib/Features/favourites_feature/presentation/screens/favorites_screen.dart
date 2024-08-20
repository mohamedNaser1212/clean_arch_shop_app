import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';

import '../../../../core/utils/screens/widgets/custom_title.dart';
import '../../../../core/utils/styles/color_manager.dart';
import '../favourites_widgets/favourite_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouritesCubit, FavouritesState>(
      listener: (context, state) {
        if (state is ChangeFavouriteSuccessState) {
          Fluttertoast.showToast(
            msg: state.isFavourite
                ? 'Added to favourites'
                : 'Removed from favourites',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: state.isFavourite ? Colors.green : Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        return _FavoritesScreenContent(state: state);
      },
    );
  }
}

class _FavoritesScreenContent extends StatelessWidget {
  final FavouritesState state;

  const _FavoritesScreenContent({required this.state});

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
      condition: state is! ChangeFavoritesLoadingState,
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