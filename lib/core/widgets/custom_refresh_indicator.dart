import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/domain/favourites_entity/favourites_entity.dart';
import 'package:shop_app/Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_item_widget.dart';
import 'package:shop_app/Features/favourites_feature/presentation/favourites_widgets/favourite_item.dart';
import 'package:shop_app/core/widgets/loading_indicator.dart';

class CustomRefreshIndicator<T> extends StatelessWidget {
  final Future<void> Function(BuildContext context)? onRefresh;
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget fallback;

  const CustomRefreshIndicator._({
    required this.onRefresh,
    required this.items,
    required this.itemBuilder,
    this.fallback = const Center(child: LoadingIndicatorWidget()),
  });

  static CustomRefreshIndicator<FavouritesEntity> favorites({
    required BuildContext context,
  }) {
    var favourites = FavouritesCubit.get(context).getFavouritesModel;
    return CustomRefreshIndicator<FavouritesEntity>._(
      onRefresh: (context) => _handleFavoritesRefresh(context),
      items: favourites,
      itemBuilder: (context, item) => FavoriteItem(model: item),
      fallback:
          const Center(child: Text('Sorry, there are no favourites to show')),
    );
  }

  static CustomRefreshIndicator<CartEntity> carts({
    required BuildContext context,
    required List<CartEntity> model,
  }) {
    var carts = CartsCubit.get(context).cartEntity;
    return CustomRefreshIndicator<CartEntity>._(
      onRefresh: (context) => _handleCartsRefresh(context),
      items: carts,
      itemBuilder: (context, item) => CartItemWidget(model: item),
      fallback: const Center(child: Text('Your cart is empty')),
    );
  }

  static Future<void> _handleFavoritesRefresh(BuildContext context) async {
    await FavouritesCubit.get(context).getFavorites();
  }

  static Future<void> _handleCartsRefresh(BuildContext context) async {
    await CartsCubit.get(context).getCarts();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return fallback;
    }

    return RefreshIndicator(
      onRefresh: () => onRefresh!(context),
      child: _buildListView(),
    );
  }

  ListView _buildListView() {
    return ListView.separated(
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: items.length,
    );
  }
}
