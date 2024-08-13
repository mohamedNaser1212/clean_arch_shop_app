import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/end_points.dart';
import 'package:shop_app/core/widgets/reusable_widgets.dart';
import 'package:shop_app/screens/products_details_screen.dart';

import '../../Features/home/domain/entities/favourites_entity/favourites_entity.dart';
import '../../Features/home/presentation/manager/shop_cubit/shop_cubit.dart';

class FavoriteItem extends StatelessWidget {
  final FavouritesEntity model;

  const FavoriteItem({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isFavourite = favorites[model.id!] ?? false;
    var isCart = carts[model.id!] ?? false;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          navigateTo(
            context: context,
            screen: ProductsDetailsScreen(
              model: model,
            ),
          );
        },
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  CachedNetworkImage(
                    imageUrl: model.image ?? '',
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                  if (model.discount != 0)
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
                      model.name ?? 'Unknown',
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
                          '${model.price?.round() ?? 0}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        if (model.discount != 0)
                          Text(
                            '\$${model.oldPrice?.round() ?? 0}',
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
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavourite(model.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                isFavourite ? Colors.red : Colors.grey,
                            radius: 15,
                            child: const Icon(
                              Icons.favorite,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeCarts(model.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor: isCart ? Colors.red : Colors.grey,
                            radius: 15,
                            child: const Icon(
                              Icons.add_shopping_cart,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
