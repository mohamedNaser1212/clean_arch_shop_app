import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/Auth_botton.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/email_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/name_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/password_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/phone_text_field.dart';
import 'package:shop_app/core/functions/navigations_functions.dart';
import 'package:shop_app/core/utils/styles_manager/text_styles_manager.dart';

class RegisterScreenBuilder extends StatelessWidget {
  const RegisterScreenBuilder({super.key, required this.state});
  final RegisterState state;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'REGISTER',
                    style: StylesManager.textStyle30,
                  ),
                  const SizedBox(height: 15),
                  // Add your text fields here as usual
                  EmailField(controller: emailController),
                  const SizedBox(height: 10),
                  PasswordField(
                      controller: passwordController,
                      obscure: true,
                      onSuffixPressed: () {}),
                  const SizedBox(height: 10),
                  NameField(controller: nameController),
                  const SizedBox(height: 10),
                  PhoneField(controller: phoneController),
                  const SizedBox(height: 10),

                  AuthButtons(
                      isLoginPage: false,
                      action: () {
                        if (formKey.currentState!.validate()) {
                          RegisterCubit.get(context).userRegister(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      executeSecondaryAction: () {
                        NavigationManager.navigateTo(
                            context: context, screen: LoginScreen());
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
