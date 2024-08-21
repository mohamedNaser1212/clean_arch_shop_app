import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/login_use_case.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/register_screen.dart';

import '../../../../core/managers/navigations_manager/navigations_manager.dart';
import '../../../../core/managers/reusable_widgets_manager/reusable_elevated_botton.dart';
import '../../../../core/managers/reusable_widgets_manager/reusable_text_form_field.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../../domain/authentication_repo/authentication_repo.dart';
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
          getIt.get<AuthenticationRepo>(),
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
          style: TitleStyle.style14,
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
    return ReusableTextFormField(
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
    return ReusableTextFormField(
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
      builder: (context) => ReusableElevatedButton(
        onPressed: () {
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
          style: TitleStyle.style16,
          color: ColorController.blackColor,
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
            style: TitleStyle.style16,
          ),
        ),
      ],
    );
  }
}
