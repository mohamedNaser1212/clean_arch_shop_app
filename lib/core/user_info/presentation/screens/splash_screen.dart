import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/layout/presentation/screens/layout_screen.dart';
import 'package:shop_app/core/managers/navigations_manager/navigations_manager.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';

import '../../domain/use_cases/get_token_use_case.dart';
import '../cubit/user_info_cubit.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final NavigationManager navigationManager = NavigationManagerImpl();
    return BlocProvider(
      create: (context) => UserInfoCubit(
        getUserUseCase: getIt.get<GetInfoUserUseCase>(),
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
