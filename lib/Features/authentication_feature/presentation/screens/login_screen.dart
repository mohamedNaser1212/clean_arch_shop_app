import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/login_use_case.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_screen_body.dart';
import 'package:shop_app/core/functions/navigations_function.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';
import 'package:shop_app/core/user_info/domain/use_cases/get_user_info_use_case.dart';
import 'package:shop_app/core/widgets/custom_progress_indicator.dart';
import 'package:shop_app/core/widgets/initial_screen.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';
import 'package:shop_app/core/widgets/custom_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        loginUseCase: getIt.get<LoginUseCase>(),
        userDataUseCase: getIt.get<GetUserInfoUseCase>(),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: _loginListener,
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, LoginState state) {
    return BlockInteractionLoadingWidget(
      isLoading: state is LoginLoadingState,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Login',
          showLeadingIcon: false,
        ),
        body: const LoginScreenBody(),
      ),
    );
  }

  void _loginListener(BuildContext context, LoginState state) {
    if (state is LoginSuccessState) {
      NavigationFunctions.navigateAndFinish(
          context: context, screen: const InitialScreen());
    } else if (state is LoginErrorState) {
      ToastHelper.showToast(
        message: state.error,
      );
    }
  }
}
