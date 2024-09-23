import 'package:dartz/dartz.dart';
import 'package:shop_app/core/payment_gate_way_manager/domain/payment_repo/payment_repo.dart';

import '../../../managers/errors_manager/failure.dart';

class PaymentUseCase {
  final PaymentRepo paymentRepo;

  const PaymentUseCase({
    required this.paymentRepo,
  });

  Future<Either<Failure, String>> getClientSecret({
    required int amount,
    required String currency,
  }) async {
    return await paymentRepo.getClientSecret(
      amount: amount,
      currency: currency,
    );
  }

  Future<Either<Failure, void>> initializePaymentSheet({
    required String clientSecret,
  }) async {
    return await paymentRepo.initializePaymentSheet(
      clientSecret: clientSecret,
    );
  }
}
