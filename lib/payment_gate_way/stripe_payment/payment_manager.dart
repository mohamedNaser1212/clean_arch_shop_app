import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/payment_gate_way/stripe_payment/stripe_keys.dart';

import '../../Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';

abstract class PaymentManager {
  static Future<void> makePayment(int amount, String currency,
      BuildContext context, List<AddToCartEntity> model) async {
    try {
      String clientSecret =
          await _getClientSecret((amount * 100).toString(), currency);
      await _initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();

      // Collect all the item IDs to be removed
      List<num> itemIds = model.map((item) => item.id!).toList();

      // Remove all items from the cart
      bool allRemoved = await ShopCubit.get(context).changeCartsList(itemIds);

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
