import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/core/networks/api_manager/end_points.dart';
import '../../../networks/api_manager/dio_data_name.dart';
import '../../../stripe_key/stripe_keys.dart';

abstract class PaymentDataSource {
  const PaymentDataSource();
  
  Future<String> getClientSecret({
    required String amount,
    required String currency,
  });
  
  Future<void> initializePaymentSheet(
    {
      required String clientSecret,
    }
  );
}

class PaymentDataSourceImpl implements PaymentDataSource {
  @override
  Future<String> getClientSecret({
    required String amount,
    required String currency,
  }) async {
    Dio dio = Dio();

    var response = await dio.post(
      EndPoints.stripeEndPoint,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
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
  Future<void> initializePaymentSheet({
    required String clientSecret,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Nasser",
      ),
    );
  }
}
