import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/register_screen.dart';
import 'package:shop_app/core/utils/color_controllers/color_controller.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../../core/widgets/reusable_widgets.dart';
import '../../domain/authentication_repo/login_repo/login_repo.dart';
import '../../domain/login_use_case/login_use_case.dart';
import '../cubit/login_cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        LoginUseCase(
          getIt.get<LoginRepo>(),
        ),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: _loginListener,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  void _loginListener(BuildContext context, LoginState state) {
    // Implement listener logic if needed
  }

  Widget _buildBody(BuildContext context, LoginState state) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 30),
                _buildEmailField(),
                const SizedBox(height: 15),
                _buildPasswordField(context),
                const SizedBox(height: 30),
                _buildLoginButton(context, state),
                const SizedBox(height: 15),
                _buildRegisterPrompt(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTitle(
          title: 'LOGIN Screen',
          fontSize: 14,
          color: ColorController.blackColor,
          fontWeight: FontWeight.w900,
        ),
        Text(
          'login now to browse our hot offers',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return reusableTextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'please enter your email address';
        }
        return null;
      },
      label: 'Email Address',
      prefix: const Icon(Icons.email_outlined),
      onTap: () {},
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return reusableTextFormField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'please enter your password';
        }
        return null;
      },
      label: 'Password',
      obscure: LoginCubit.get(context).isPassword,
      onSubmit: (value) {
        if (formKey.currentState!.validate()) {
          LoginCubit.get(context).userLogin(
            email: emailController.text,
            password: passwordController.text,
            context: context,
          );
        }
      },
      prefix: const Icon(Icons.lock_outline),
      onTap: () {},
    );
  }

  Widget _buildLoginButton(BuildContext context, LoginState state) {
    return ConditionalBuilder(
      condition: state is! AppLoginLoadingState,
      builder: (context) => reusableElevatedButton(
        function: () {
          if (formKey.currentState!.validate()) {
            LoginCubit.get(context).userLogin(
              email: emailController.text,
              password: passwordController.text,
              context: context,
            );
          }
        },
        label: 'login',
        width: double.infinity,
        height: 50,
        radius: 20,
      ),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildRegisterPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomTitle(
          title: 'Don\'t have an account?',
          fontSize: 16,
          color: ColorController.blackColor,
          fontWeight: FontWeight.w500,
        ),
        TextButton(
          onPressed: () {
            navigateTo(
              context: context,
              screen: RegisterScreen(),
            );
          },
          child: const CustomTitle(
            title: 'Register Now',
            fontSize: 16,
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
