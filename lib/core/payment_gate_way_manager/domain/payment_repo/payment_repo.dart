import 'package:dartz/dartz.dart';
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
