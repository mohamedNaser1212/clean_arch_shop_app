import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/data/model/register_request_model.dart';
import 'package:shop_app/Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/Auth_botton.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/email_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/name_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/password_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/phone_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/register_form.dart';
import 'package:shop_app/core/functions/navigations_functions.dart';
import 'package:shop_app/core/utils/styles_manager/text_styles_manager.dart';

class RegisterScreenBuilder extends StatefulWidget {
  const RegisterScreenBuilder({super.key, });

  @override
  State<RegisterScreenBuilder> createState() => RegisterScreenBuilderState();
}

class RegisterScreenBuilderState extends State<RegisterScreenBuilder> {
  late final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'REGISTER',
                    style: StylesManager.textStyle30,
                  ),
                  const SizedBox(height: 15),
                  RgisterForm(
                    requestModel: this,
                  ),
                  const SizedBox(height: 10),
                  AuthButtons(
                      isLoginPage: false,
                      action: () {
                        if (formKey.currentState!.validate()) {
                          RegisterCubit.get(context).userRegister(
                            requestModel: RegisterRequestModel(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                            ),
                          );
                        }
                      },
                      navigatioAction: () {
                        NavigationManager.navigateTo(
                            context: context, screen: const LoginScreen());
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
