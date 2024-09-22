import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_app/Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/register_screen.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/Auth_botton.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/email_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_header.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/password_text_field.dart';
import 'package:shop_app/core/functions/navigations_functions.dart';

import '../cubit/login_cubit/login_state.dart';

class LoginBuilder extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LoginState state;

  const LoginBuilder({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginHeader(),
                const SizedBox(height: 30),
                EmailField(controller: emailController),
                const SizedBox(height: 15),
                PasswordField(
                  controller: passwordController,
                  obscure: true,
                  onSuffixPressed: () {},
                ),
                const SizedBox(height: 30),
                const SizedBox(height: 15),
                AuthButtons(
                  action: () {
                    if (formKey.currentState!.validate()) {
                      LoginCubit.get(context).login(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                  navigatioAction: () => NavigationManager.navigateTo(
                    context: context,
                    screen: const RegisterScreen(),
                  ),
                  isLoginPage: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
