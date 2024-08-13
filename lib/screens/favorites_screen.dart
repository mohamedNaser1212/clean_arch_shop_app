import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_state.dart';

import '../core/widgets/favourite_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopToggleFavoriteSuccessState) {
          Fluttertoast.showToast(
            msg: state.isFavourite.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor:
                state.isFavourite.status! ? Colors.green : Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        var favouritesModel = ShopCubit.get(context).getFavouritesModel;
        if (favouritesModel.isEmpty) {
          return const Center(
            child: Text('Sorry, there are no favourites to show'),
          );
        }
        return ConditionalBuilder(
          condition: state is! ShopGetFavoritesLoadingState &&
              state is! ShopToggleFavoriteLoadingState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                FavoriteItem(model: favouritesModel[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: favouritesModel.length,
          ),
          fallback: (context) => Center(
            child:
                LoadingAnimationWidget.waveDots(color: Colors.grey, size: 90),
          ),
        );
      },
    );
  }
}
