
import 'package:flutter/material.dart';
import 'package:shop_app/core/payment_gate_way_manager/cubit/payment_cubit.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_elevated_botton.dart';

class CheckOutBotton extends StatelessWidget {
  const CheckOutBotton({
    super.key,
    required this.total,
  });

  final num total;

  @override
  Widget build(BuildContext context) {
    return ReusableElevatedButton(
      label: 'CheckOut',
      onPressed: () {
        PaymentCubit.get(context).getClientSecret(
          amount: total.toInt(),
          currency: 'EGP',
        );
      },
    );
  }
}