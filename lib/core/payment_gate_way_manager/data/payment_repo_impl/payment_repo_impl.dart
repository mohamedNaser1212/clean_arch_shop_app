import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';

import '../../../../Features/carts_feature/presentation/cubit/carts_cubit.dart';
import '../../domain/payment_repo/payment_repo.dart';
import '../payment_data_source/payment_data_source.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentDataSource paymentManager;

  PaymentRepoImpl({
    required this.paymentManager,
  });
  @override
  Future<void> makePayment(int amount, String currency, BuildContext context,
      List<CartEntity> model) async {
    try {
      String clientSecret = await paymentManager.getClientSecret(
          (amount * 100).toString(), currency);
      await paymentManager.initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();

      final itemIds = model.map((e) => e.id).whereType<num>().toList();

      if (!context.mounted) return;
      bool allRemoved =
          (await CartsCubit.get(context).changeCartsList(itemIds));
      //put this in the success state
      if (allRemoved) {
        print('Payment and cart removal succeeded');
      } else {
        print(
            'Payment succeeded, but failed to remove one or more items from the cart');
      }
    } catch (e) {
      print('Error during payment: $e');
    }
  }
}
