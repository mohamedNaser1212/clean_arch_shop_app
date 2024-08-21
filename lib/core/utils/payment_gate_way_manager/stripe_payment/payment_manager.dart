import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/core/utils/payment_gate_way_manager/stripe_payment/stripe_keys.dart';

import '../../../../Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';
import '../../../../Features/carts_feature/presentation/cubit/carts_cubit.dart';

abstract class PaymentManager {
  static Future<void> makePayment(int amount, String currency,
      BuildContext context, List<AddToCartEntity> model) async {
    try {
      String clientSecret =
          await _getClientSecret((amount * 100).toString(), currency);
      await _initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();

      // Map the entity IDs and filter out any null values
      final itemIds = model.map((e) => e.id).whereType<num>().toList();

      if (!context.mounted) return;

      // Ensure `allRemoved` has a boolean value even if `changeCartsList` returns null
      bool allRemoved =
          (await CartsCubit.get(context).changeCartsList(itemIds)) ?? false;

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

  static Future<void> _initializePaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Naser",
      ),
    );
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();

    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      ),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );
    return response.data["client_secret"];
  }
}
