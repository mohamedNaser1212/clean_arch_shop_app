import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';
import '../../../errors_manager/failure.dart';

abstract class PaymentRepo {
  const PaymentRepo();
  Future<Either<Failure, String>> getClientSecret({
    required int amount,
    required String currency,
  });

  Future<Either<Failure, void>> initializePaymentSheet({
    required String clientSecret,
  });
}
