import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/data/model/login_request_model.dart';
import 'package:shop_app/Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_elevated_botton.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.state,
  }) : super(key: key);
  final LoginScreenState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LoginButton(state: state),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.state,
  });

  final LoginScreenState state;

  @override
  Widget build(BuildContext context) {
    return ReusableElevatedButton(
        label: 'Login',
        onPressed: () {
          if (state.formKey.currentState!.validate()) {
            LoginCubit.get(context).login(
              requestModel: LoginRequestModel(
                email: state.emailController.text,
                password: state.passwordController.text,
              ),
            );
          }
        });
  }
}
