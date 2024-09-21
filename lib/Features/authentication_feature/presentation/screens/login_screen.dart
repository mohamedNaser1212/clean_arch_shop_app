import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_screen_builder.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import '../../../layout/presentation/screens/layout_screen.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: _loginListener,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: LoginBuilder(
            formKey: formKey,
            emailController: emailController,
            passwordController: passwordController,
            state: state,
          ),
        );
      },
    );
  }

  Future<void> _loginListener(BuildContext context, LoginState state) async {
    if (state is AppLoginSuccessState) {
      // Handle successful login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LayoutScreen()),
        (route) => false,
      );
    } else if (state is AppLoginErrorState) {
      showToast(
        isError: true,
        message: state.error,
      );
    }
  }



}
