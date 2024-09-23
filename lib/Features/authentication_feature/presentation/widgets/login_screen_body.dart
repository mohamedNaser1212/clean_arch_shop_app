import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/email_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_botton.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_header.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/password_text_field.dart';

import 'dont_have_account_widget.dart';

class LoginBody extends StatelessWidget {
  final LoginScreenState state;

  const LoginBody({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: state.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginHeader(),
                const SizedBox(height: 30),
                EmailField(controller: state.emailController),
                const SizedBox(height: 15),
                PasswordField(
                  controller: state.passwordController,
                  obscure: true,
                  onSuffixPressed: () {},
                ),
                const SizedBox(height: 30),
                LoginButton(state: state),
                CheckAuthStatusTextWidget.login(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
