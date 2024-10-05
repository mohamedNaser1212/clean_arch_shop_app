import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/form_fields/email_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_botton.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_header.dart';
import 'package:shop_app/core/widgets/form_fields/password_text_field.dart';

import 'auth_status_text_widget.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreenBody> createState() => LoginScreenBodyState();
}

class LoginScreenBodyState extends State<LoginScreenBody> {
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
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
              ),
              const SizedBox(height: 30),
              LoginButton( 
                state: this,
              ),
              AuthStatusTextWidget.login(context: context),
            ],
          ),
        ),
      ),
    );
  }
}
