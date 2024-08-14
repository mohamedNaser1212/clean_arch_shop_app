import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/reusable_widgets.dart';

import '../../Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';
import '../../payment_gate_way/stripe_payment/payment_manager.dart';

class CartCheckoutData extends StatelessWidget {
  final num? subtotal;
  final num? total;
  final List<AddToCartEntity>? cartModel;

  const CartCheckoutData({
    super.key,
    required this.subtotal,
    required this.total,
    this.cartModel, // Changed to nullable
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subtotal: \$${subtotal?.toStringAsFixed(2) ?? '0.00'}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total: \$${total?.toStringAsFixed(2) ?? '0.00'}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          reusableElevatedButton(
            label: 'CheckOut',
            function: () {
              if (cartModel != null) {
                PaymentManager.makePayment(
                  total!.toInt(),
                  'EGP',
                  context,
                  cartModel!,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
