import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/core/managers/repo_manager/repo_manager.dart';

import '../../../errors_manager/failure.dart';
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
  Future<Either<Failure, bool>> makePayment(int amount, String currency,
      BuildContext context, List<CartEntity> model) async {
    return repoManager.call(
      action: () async {
        String clientSecret = await paymentManager.getClientSecret(
            (amount * 100).toString(), currency);
        await paymentManager.initializePaymentSheet(clientSecret);
        await Stripe.instance.presentPaymentSheet();

        return true;
      },
    );
  }
}
