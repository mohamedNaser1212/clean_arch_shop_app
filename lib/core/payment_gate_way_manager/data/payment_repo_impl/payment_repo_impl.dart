import 'package:dartz/dartz.dart';
import 'package:shop_app/core/managers/repo_manager/repo_manager.dart';

import '../../../managers/errors_manager/failure.dart';
import '../../domain/payment_repo/payment_repo.dart';
import '../payment_data_source/payment_data_source.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentDataSource paymentManager;
  final RepoManager repoManager;

  const PaymentRepoImpl({
    required this.paymentManager,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, String>> getClientSecret(
      {required int amount, required String currency}) async {
    return repoManager.call(
      action: () async {
        String clientSecret = await paymentManager.getClientSecret(
          amount: (amount * 100).toString(),
          currency: currency,
        );
        return clientSecret;
      },
    );
  }

  @override
  Future<Either<Failure, void>> initializePaymentSheet({
    required String clientSecret,
  }) async {
    return repoManager.call(
      action: () async {
        await paymentManager.initializePaymentSheet(clientSecret: clientSecret);
      },
    );
  }
}
