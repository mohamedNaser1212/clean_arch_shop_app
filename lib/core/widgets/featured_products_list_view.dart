import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/product_item.dart';

import '../../Features/home/domain/entities/products_entity/product_entity.dart';

class FeaturedProductsListView extends StatelessWidget {
  const FeaturedProductsListView(
      {Key? key, required this.products, required this.isFavourite})
      : super(key: key);

  final List<ProductEntity> products;
  final bool isFavourite;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ProductItem(
              product: product,
              isFavourite: isFavourite,
            ),
          );
        },
      ),
    );
  }
}
