import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/core/networks/api_manager/end_points.dart';

import '../../../networks/api_manager/dio_data_name.dart';
import '../../../stripe_key/stripe_keys.dart';

abstract class PaymentDataSource {
  const PaymentDataSource();
  Future<String> getClientSecret(String amount, String currency);
  Future<void> initializePaymentSheet(String clientSecret);
}

class PaymentPaymentDataSourceImpl implements PaymentDataSource {
  @override
  Future<String> getClientSecret(String amount, String currency) async {
    Dio dio = Dio();

    var response = await dio.post(
     EndPoints.stripeEndPoint,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      ),
      data: {
        RequestDataNames.amount: amount,
         RequestDataNames.currency: currency,
      },
    );
    return response.data["client_secret"];
  }

  @override
  Future<void> initializePaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Naser",
      ),
    );
  }
}
// static Future<String> _getClientSecret(String amount, String currency) async {
// Dio dio = Dio();
//
// var response = await dio.post(
// 'https://api.stripe.com/v1/payment_intents',
// options: Options(
// headers: {
// 'Authorization': 'Bearer ${ApiKeys.secretKey}',
// 'Content-Type': 'application/x-www-form-urlencoded'
// },
// ),
// data: {
// 'amount': amount,
// 'currency': currency,
// },
// );
// return response.data["client_secret"];
// }
