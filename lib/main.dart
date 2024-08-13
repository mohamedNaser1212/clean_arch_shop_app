import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shop_app/core/utils/funactions/set_up_service_locator.dart';
import 'package:shop_app/core/utils/funactions/start_page.dart';
import 'package:shop_app/core/widgets/cache_helper.dart';
import 'package:shop_app/core/widgets/constants.dart';
import 'package:shop_app/core/widgets/old_dio_helper.dart';
import 'package:shop_app/payment_gate_way/stripe_payment/stripe_keys.dart';

import 'Features/home/presentation/manager/get_user_data_cubit/get_user_data_cubit.dart';
import 'Features/home/presentation/manager/login_cubit/login_cubit.dart';
import 'Features/home/presentation/manager/register_cubit/register_cubit.dart';
import 'Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'bloc_observer/bloc_observer.dart';
import 'core/utils/funactions/hive_open_boxes.dart';
import 'core/utils/funactions/hive_register_adapter.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Stripe.publishableKey = ApiKeys.publishableKey;

  HiveRegisterAdapters();

  await CacheHelper.init();
  DioHelper.init();
  setUpServiceLocator();

  Widget? startingScreen = startPage();
  await hiveOpenBoxes();

  runApp(MyApp(startingScreen: startingScreen!));
}

class MyApp extends StatelessWidget {
  final Widget startingScreen;

  MyApp({required this.startingScreen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<ShopCubit>()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavorites()
              ..getCartItems()),
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
        home: startingScreen,
        theme: lightTheme,
      ),
    );
  }
}
