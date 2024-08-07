import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key, required this.model, required this.isInCart});
  final AddToCartEntity model;
  final bool isInCart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: model.image,
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text('Price: ${model.price}'),
                const SizedBox(height: 5),
                Text('Quantity: ${model.quantity}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
