import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/core/utils/funactions/start_page.dart';
import 'package:shop_app/core/utils/screens/splash_screen.dart';

import 'Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import 'Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import 'Features/carts_feature/payment_gate_way/stripe_payment/stripe_keys.dart';
import 'Features/home/presentation/cubit/shop_cubit/shop_cubit.dart';
import 'Features/settings_feature/presentation/cubit/get_user_info_cubit/get_user_data_cubit.dart';
import 'core/models/hive_manager/hive_manager.dart';
import 'core/service_locator/service_locator.dart';
import 'core/utils/bloc_observer/bloc_observer.dart';
import 'core/utils/screens/error_screen.dart';
import 'core/utils/screens/widgets/cache_helper.dart';
import 'core/utils/screens/widgets/constants.dart';
import 'core/utils/screens/widgets/old_dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveManager.initialize();
  Bloc.observer = MyBlocObserver();
  Stripe.publishableKey = ApiKeys.publishableKey;

  await CacheHelper.init();
  DioHelper.init();

  setUpServiceLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<ShopCubit>()
              ..getCartItems()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavorites()),
        BlocProvider(
          create: (context) => getIt<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<RegisterCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<UserDataCubit>(),
        ),
      ],
      child: MaterialApp(
        home: FutureBuilder<Widget>(
          future: determineStartPage(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            } else if (snapshot.hasError) {
              return ErrorScreen(error: snapshot.error.toString());
            }
            return snapshot.data!;
          },
        ),
        theme: lightTheme,
      ),
    );
  }
}
