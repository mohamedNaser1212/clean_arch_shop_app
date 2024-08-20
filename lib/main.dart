import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:shop_app/core/models/hive_manager/hive_manager.dart';
import 'package:shop_app/core/utils/funactions/start_page.dart';
import 'package:shop_app/core/utils/screens/splash_screen.dart';

import 'Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import 'Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import 'Features/carts_feature/payment_gate_way/stripe_payment/stripe_keys.dart';
import 'Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import 'Features/settings_feature/presentation/cubit/user_info_cubit/user_data_cubit.dart';
import 'core/service_locator/service_locator.dart';
import 'core/utils/api_services/api_service_interface.dart';
import 'core/utils/bloc_observer/bloc_observer.dart';
import 'core/utils/screens/error_screen.dart';
import 'core/utils/screens/widgets/cache_helper.dart';
import 'core/utils/screens/widgets/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive with a storage path
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  setUpServiceLocator();
  HiveManager().initialize();

  Bloc.observer = MyBlocObserver();
  Stripe.publishableKey = ApiKeys.publishableKey;

  await HiveHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                getIt<GetProductsCubit>()..getProductsData(context: context)),
        BlocProvider(
            create: (context) => getIt<CategoriesCubit>()..getCategoriesData()),
        BlocProvider(
          create: (context) => getIt<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<RegisterCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<UserDataCubit>()..getUserData(),
        ),
        BlocProvider(
          create: (context) => getIt<FavouritesCubit>()..getFavorites(),
        ),
        BlocProvider(create: (context) => getIt<CartsCubit>()..getCartItems()),
      ],
      child: MaterialApp(
        home: FutureBuilder<Widget>(
          future: determineStartPage(context, getIt<ApiServiceInterface>()),
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
