import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/register_screen_body.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_progress_indicator.dart';
import 'package:shop_app/core/widgets/initial_screen.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../cubit/register_cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: _listener,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, RegisterState state) {
    return CustomProgressIndicator(
      isLoading: state is RegisterLoadingState,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: const RegisterScreenBody(),
      ),
    );
  }
}

void _listener(BuildContext context, RegisterState state) {
  if (state is RegisterSuccessState) {
    showToast(
      color: ColorController.greenAccent,
      message: 'Register Success',
    );

    ProductsCubit.get(context).homeModel;
    UserInfoCubit.get(context).userEntity = state.userModel;

    NavigationManager.navigateAndFinish(
      context: context,
      screen: const InitialScreen(),
    );
  } else if (state is RegisterErrorState) {
    showToast(
      message: state.message,
    );
  }
}
