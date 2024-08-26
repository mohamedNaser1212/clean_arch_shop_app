import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/layout/presentation/screens/layout_screen.dart';
import 'package:shop_app/core/managers/navigations_manager/navigations_manager.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';

import '../../Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../user_info/domain/use_cases/get_user_info_use_case.dart';
import '../user_info/presentation/cubit/user_info_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserInfoCubit userInfoCubit = getIt<UserInfoCubit>();

  @override
  void initState() {
    super.initState();
    userInfoCubit.getUserData();
    GetProductsCubit.get(context).getProductsData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final NavigationManager navigationManager = NavigationManagerImpl();
    return BlocProvider(
      create: (context) => UserInfoCubit(
        getUserUseCase: getIt.get<GetUserInfoUseCase>(),
      )..getUserData(),
      child: BlocConsumer<UserInfoCubit, UserInfoState>(
        listener: (context, state) {
          if (state is GetUserInfoSuccessState) {
            navigationManager.navigateAndFinish(
                context: context, screen: const LayoutScreen());
          } else if (state is GetUserInfoErrorState) {
            navigationManager.navigateAndFinish(
                context: context, screen: LoginScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Image.asset(
              'assets/images/groot.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
