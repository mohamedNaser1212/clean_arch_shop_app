import 'package:flutter/material.dart';

import '../../../../core/utils/color_controllers/color_controller.dart';

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
            color: ColorController.textColorPrimary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                '${product.price!.round()}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorController.blackColor,
                ),
              ),
              const SizedBox(width: 5),
              if (product.discount != 0)
                Text(
                  '${product.oldPrice!.round()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                    color: ColorController.warningColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
