import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/reusable_widgets.dart';

import '../../Features/home/domain/entities/products_entity/product_entity.dart';
import '../../Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import '../../screens/products_details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
          context: context,
          screen: ProductsDetailsScreen(model: product),
        );
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: CachedNetworkImageProvider(product.image!),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  if (product.discount != 0)
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
              Text(
                product.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      '${product.price!.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (product.discount != 0)
                      Text(
                        '${product.oldPrice!.round()}',
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
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavourite(product.id!);
                    },
                    icon: CircleAvatar(
                      backgroundColor:
                          ShopCubit.get(context).favorites[product.id] ?? false
                              ? Colors.red
                              : Colors.grey,
                      radius: 15,
                      child: const Icon(
                        Icons.favorite,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     ShopCubit.get(context).toggleCart([product.id]);
                  //   },
                  //   icon: CircleAvatar(
                  //     backgroundColor: isCart ? Colors.red : Colors.grey,
                  //     radius: 15,
                  //     child: const Icon(
                  //       Icons.shopping_cart,
                  //       size: 15,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
