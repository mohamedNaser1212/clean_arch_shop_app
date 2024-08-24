import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_item.dart';

import '../../data/home_models/products_models/products_response_model.dart';

class FeaturedProductsListView extends StatelessWidget {
  const FeaturedProductsListView(
      {Key? key,
      required this.products,
      required this.isFavourite,
      required this.isCart})
      : super(key: key);

  final List<ProductResponseModel> products;
  final bool isFavourite;
  final bool isCart;
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
            ),
          );
        },
      ),
    );
  }
}
