import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';
import '../../../errors_manager/failure.dart';

abstract class PaymentRepo {
  Future<Either<Failure, bool>> makePayment(int amount, String currency,
      BuildContext context, List<CartEntity> model);
}
