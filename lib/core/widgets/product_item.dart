import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';

import '../../Features/home/presentation/manager/shop_cubit/shop_cubit.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key, required this.product, required this.isFavourite})
      : super(key: key);

  final ProductEntity product;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  image: CachedNetworkImageProvider(product.image),
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
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Text(
                  '${product.price.round()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 5),
                if (product.discount != 0)
                  Text(
                    '${product.oldPrice.round()}',
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
            IconButton(
              onPressed: () {
                ShopCubit.get(context).toggleFavourite(product.id);
              },
              icon: CircleAvatar(
                backgroundColor: isFavourite ? Colors.red : Colors.grey,
                radius: 15,
                child: const Icon(
                  Icons.favorite,
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
