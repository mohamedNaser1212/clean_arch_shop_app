import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shop_app/Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';

import '../../../../Features/carts_feature/presentation/cubit/carts_cubit.dart';
import '../../../errors_manager/failure.dart';
import '../../../errors_manager/internet_failure.dart';
import '../../../initial_screen/manager/internet_manager/internet_manager.dart';
import '../../domain/payment_repo/payment_repo.dart';
import '../payment_data_source/payment_data_source.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentDataSource paymentManager;
  final InternetManager internetManager;

  PaymentRepoImpl({
    required this.paymentManager,
    required this.internetManager,
  });
  @override
  Future<Either<Failure, bool>> makePayment(int amount, String currency,
      BuildContext context, List<CartEntity> model) async {
    try {
      final isConnected = await internetManager.checkConnection();
      if (!isConnected) {
        InternetFailure.fromConnectionStatus(
            InternetConnectionStatus.disconnected);
      }
      String clientSecret = await paymentManager.getClientSecret(
          (amount * 100).toString(), currency);
      await paymentManager.initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();


      return right(true);
    } catch (e) {
      print('Error during payment: $e');
    }
    return left(const ServerFailure(message: 'Error during payment'));
  }
}
