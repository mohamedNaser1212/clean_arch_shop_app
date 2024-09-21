import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../cubit/favourites_cubit.dart';
import '../favourites_widgets/favourite_item.dart';

class FavoritesScreenBody extends StatelessWidget {
  final FavouritesState state;

  const FavoritesScreenBody({
    super.key,
    required this.state,
  });

  Future<void> _refreshFavorites(BuildContext context) async {
    await FavouritesCubit.get(context).getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    var favouritesModel = FavouritesCubit.get(context).getFavouritesModel;

    return CustomRefreshIndicator(
      onRefresh: _refreshFavorites,
      items: favouritesModel,
      itemBuilder: (context, model) => FavoriteItem(model: model),
      fallback: const Center(
        child: Text('Sorry, there are no favourites to show'),
      ),
    );
  }
}
