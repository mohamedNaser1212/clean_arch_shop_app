import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/layout/presentation/screens/layout_screen.dart';
import 'package:shop_app/core/functions/navigations_functions.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';

import '../user_info/cubit/user_info_cubit.dart';
import '../user_info/domain/use_cases/get_user_info_use_case.dart';
import 'custom_title.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserInfoCubit>(
      create: (context) => UserInfoCubit(
        getUserUseCase: getIt<GetUserInfoUseCase>(),
      )..getUserData(),
      child: BlocConsumer<UserInfoCubit, UserInfoState>(
        listener: _listener,
        builder: _userInfoBuilder,
      ),
    );
  }

  Widget _userInfoBuilder(context, state) {
    if (state is GetUserInfoLoadingState) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is GetUserInfoErrorState) {

      return Scaffold(
        body: Center(
          child: CustomTitle(
              title: state.message, style: TitleStyle.style16),
        ),
      );
    }
    return const Scaffold(
      body: SizedBox(),
    );
  }

  void _listener(context, state) {
    if (state is GetUserInfoSuccessState) {
      if (state.userEntity == null) {
        NavigationManager.navigateAndFinish(
          context: context,
          screen: const LoginScreen(),
        );
      } else {

        UserInfoCubit.get(context).userEntity = state.userEntity;

        NavigationManager.navigateAndFinish(
          context: context,
          screen: const LayoutScreen(),
        );
      }
    }
  }
}
