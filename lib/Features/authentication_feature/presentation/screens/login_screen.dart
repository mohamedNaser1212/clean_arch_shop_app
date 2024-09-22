import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_screen_builder.dart';
import 'package:shop_app/core/functions/navigations_functions.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/widgets/custom_progress_indicator.dart';
import 'package:shop_app/core/widgets/initial_screen.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: _loginListener,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, LoginState state) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [

          LoginBuilder(state: this),


          if (state is LoginLoadingState)
            const CustomProgressIndicator(),
        ],
      ),
    );
  }

  void _loginListener(BuildContext context, LoginState state) {
    if (state is LoginSuccessState) {
      NavigationManager.navigateAndFinish(
          context: context, screen: const InitialScreen());
    } else if (state is LoginErrorState) {
      showToast(
        isError: true,
        message: state.error,
      );
    }
  }
}
