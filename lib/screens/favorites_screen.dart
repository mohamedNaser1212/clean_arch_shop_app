import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';

import '../Features/home/presentation/manager/shop_cubit/shop_state.dart';
import '../models/GetFavouritsModel.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var favoritesModel = ShopCubit.get(context).getFavouritesModel;
        if (favoritesModel == null || favoritesModel.isEmpty) {
          print('No Favorites');
          return Center(child: CircularProgressIndicator());
        }
        return ConditionalBuilder(
          condition: state is! ShopGetFavoritesLoadingState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildFavItem(context, favoritesModel[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: favoritesModel!.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildFavItem(BuildContext context, Product model) {
    // var product = model.product;
    // if (product == null) return SizedBox();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(2),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        '${model.price!.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                      if (model.discount != 0)
                        Text(
                          '\$${model.oldPrice!.round()}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // ShopCubit.get(context).changeFavorites(model.product!.id!);
              },
              icon: CircleAvatar(
                backgroundColor:
                    // ShopCubit.get(context).favorites[model.product!.id!]!
                    //     ? Colors.amber
                    //     :

                    Colors.grey,
                radius: 15,
                child: const Icon(
                  Icons.favorite_border,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
