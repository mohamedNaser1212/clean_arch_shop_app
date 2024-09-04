import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/payment_gate_way_manager/domain/payment_repo/payment_repo.dart';

import '../../../../Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';
import '../../../errors_manager/failure.dart';

class PaymentUseCase {
  final PaymentRepo paymentRepo;

  const PaymentUseCase({
    required this.paymentRepo,
  });

  Future<Either<Failure, bool>> makePayment(int amount, String currency,
      BuildContext context, List<CartEntity> model) async {
    return await paymentRepo.makePayment(amount, currency, context, model);
  }
}
