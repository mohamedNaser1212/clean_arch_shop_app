import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/layout/presentation/screens/layout_screen.dart';
import 'package:shop_app/core/managers/navigations_manager/navigations_manager.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';

import '../../../user_info/cubit/user_info_cubit.dart';
import '../../../user_info/domain/use_cases/get_user_info_use_case.dart';
import '../connection_failure_widget.dart';

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
        listener: _handleStateListener,
        builder: _buildBody,
      ),
    );
  }

  void _handleStateListener(BuildContext context, UserInfoState state) {
    if (state is GetUserInfoSuccessState) {
      if (state.userEntity.name!.isEmpty) {
        NavigationManager.navigateAndFinish(
          context: context,
          screen: LoginScreen(),
        );
      } else {
        NavigationManager.navigateAndFinish(
          context: context,
          screen: const LayoutScreen(),
        );
      }
    } else if (state is GetUserInfoErrorState) {
      NavigationManager.navigateAndFinish(
        context: context,
        screen: LoginScreen(),
      );
    }
  }

  Widget _buildBody(BuildContext context, UserInfoState state) {
    if (state is InternetFailureState) {
      return ConnectionFailureWidget(
        onPressed: () {
          UserInfoCubit.get(context).getUserData();
        },
      );
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
