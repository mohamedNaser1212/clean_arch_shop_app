import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/core/utils/funactions/save_carts.dart';
import 'package:shop_app/core/widgets/end_points.dart';
import 'package:shop_app/payment_gate_way/stripe_payment/stripe_keys.dart';

import '../../Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';

abstract class PaymentManager {
  static Future<void> makePayment(int amount, String currency,
      BuildContext context, List<AddToCartEntity>? model) async {
    try {
      String clientSecret =
          await _getClientSecret((amount * 100).toString(), currency);
      await _initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();

      // Properly handle the list of cart item IDs
      List<num>? cartIds =
          ShopCubit.get(context).cartModel?.map((e) => e.id!).toList();
      if (cartIds != null) {
        ShopCubit.get(context).clearCartCache();
      }

      ShopCubit.get(context).cartModel?.clear();

      loadCarts(kCartBox).then((value) {
        model = value;
      });

      model?.clear();
    } catch (error) {
      print(error.toString());
      throw Exception(error.toString());
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
