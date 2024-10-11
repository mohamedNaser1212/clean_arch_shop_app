import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/auth_status_text_widget.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_botton.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_header.dart';
import 'package:shop_app/core/widgets/form_fields/email_text_field.dart';
import 'package:shop_app/core/widgets/form_fields/password_text_field.dart';

class LoginForn extends StatefulWidget {
  const LoginForn({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginForn> createState() => LoginFornState();
}

class LoginFornState extends State<LoginForn> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoginHeader(),
          const SizedBox(height: 30),
          EmailField(controller: widget.emailController),
          const SizedBox(height: 15),
          PasswordField(
            controller: widget.passwordController,
          ),
          const SizedBox(height: 30),
          LoginButton(
            state: this,
          ),
          AuthStatusTextWidget.login(context: context),
        ],
      ),
    );
  }
}
