import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../cubit/get_favourites_cubit/favourites_cubit.dart';

class FavoritesScreenBody extends StatelessWidget {
  final FavouritesState state;

  const FavoritesScreenBody({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator.favorites(context: context);
  }
}
