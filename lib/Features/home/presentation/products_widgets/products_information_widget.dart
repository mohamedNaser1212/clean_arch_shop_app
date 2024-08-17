import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/end_points.dart';

class ProductInformationWidget extends StatelessWidget {
  const ProductInformationWidget({super.key, required this.product});
  final dynamic product;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name!,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                '${product.price!.round()}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 5),
              if (product.discount != 0)
                Text(
                  '${product.oldPrice!.round()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                    color: blackColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
