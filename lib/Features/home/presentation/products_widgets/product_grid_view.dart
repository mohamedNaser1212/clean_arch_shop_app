import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_item.dart';

import '../../domain/entities/products_entity/product_entity.dart';

class ProductsGridView extends StatelessWidget {
  ProductsGridView({super.key, required this.products});
  List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 1 / 1.99,
        children: List.generate(
          products.length,
          (index) => ProductItem(
            product: products[index],
          ),
        ),
      ),
    );
  }
}
