import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/register_screen_body.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';
import 'package:shop_app/core/user_info/domain/use_cases/get_user_info_use_case.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';
import 'package:shop_app/core/widgets/custom_app_bar.dart';
import 'package:shop_app/core/widgets/custom_progress_indicator.dart';
import 'package:shop_app/core/widgets/initial_screen.dart';
import '../../../../core/functions/navigations_function.dart';
import '../cubit/register_cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        loginUseCase: getIt.get<RegisterUseCase>(),
        userDataUseCase: getIt.get<GetUserInfoUseCase>(),
      ),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }
  Widget _builder(BuildContext context, RegisterState state) {
    return CustomProgressIndicator(
      isLoading: state is RegisterLoadingState,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Register Screen',
        ),
        body: const RegisterScreenBody(),
      ),
    );
  }
}
void _listener(BuildContext context, RegisterState state) {
  if (state is RegisterSuccessState) {
    ToastFunction.showToast(
      color: ColorController.greenAccent,
      message: 'Registeration Success',
    );
    NavigationFunctions.navigateAndFinish(
      context: context,
      screen: const InitialScreen(),
    );
  } else if (state is RegisterErrorState) {
    ToastFunction.showToast(
      message: state.message,
    );
  }
}
