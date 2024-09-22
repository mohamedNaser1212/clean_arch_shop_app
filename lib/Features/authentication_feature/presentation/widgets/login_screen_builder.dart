import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/data/model/login_request_model.dart';
import 'package:shop_app/Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/register_screen.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/Auth_botton.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/email_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_header.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/password_text_field.dart';
import 'package:shop_app/core/functions/navigations_functions.dart';


class LoginBuilder extends StatelessWidget {
  final LoginScreenState state;

  const LoginBuilder({
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
                  controller:state. passwordController,
                  obscure: true,
                  onSuffixPressed: () {},
                ),
                const SizedBox(height: 30),
                const SizedBox(height: 15),
                AuthButtons(
                  action: () {
                    if (state.formKey.currentState!.validate()) {
                      LoginCubit.get(context).login(
                        requestModel: LoginRequestModel(
                          email: state.emailController.text,
                          password: state.passwordController.text,
                        ),
                        
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
