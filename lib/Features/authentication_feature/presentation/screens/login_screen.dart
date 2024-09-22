import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_screen_builder.dart';
import 'package:shop_app/core/functions/navigations_functions.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/widgets/initial_screen.dart';
import '../../../layout/presentation/screens/layout_screen.dart';
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
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: LoginBuilder(
            state: this,
          ),
        );
      },
    );
  }

  Future<void> _loginListener(BuildContext context, LoginState state) async {
    if (state is AppLoginSuccessState) {
      // Handle successful login
      NavigationManager.navigateAndFinish(
          context: context, screen: const InitialScreen());
    } else if (state is AppLoginErrorState) {
      showToast(
        isError: true,
        message: state.error,
      );
    }
  }
}
