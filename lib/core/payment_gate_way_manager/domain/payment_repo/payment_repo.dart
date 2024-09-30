import 'package:dartz/dartz.dart';

import '../../../managers/errors_manager/failure.dart';

abstract class PaymentRepo {
  const PaymentRepo._();
  Future<Either<Failure, String>> getClientSecret({
    required int amount,
    required String currency,
  });

  Future<Either<Failure, void>> initializePaymentSheet({
    required String clientSecret,
  });
}
