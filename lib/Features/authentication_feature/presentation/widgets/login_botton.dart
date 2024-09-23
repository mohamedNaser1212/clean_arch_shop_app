import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/data/model/login_request_model.dart';
import 'package:shop_app/Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/register_screen.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/dont_have_account_widget.dart';
import 'package:shop_app/core/functions/navigations_functions.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_elevated_botton.dart';

class x extends StatelessWidget {
  const x({
    Key? key,
    required this.state,
  }) : super(key: key);
  final LoginScreenState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LodinButton(state: state),
        const SizedBox(height: 10),
        const _ActionButtons(),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return CheckAuthStatusTextWidget(
      onRegisterPressed:()=>_onRegisterPressed(context),
      title: 'Don\'t have an account?',
      subtitle: 'Register',
    );
  }
  
  void _onRegisterPressed(BuildContext context) {
    NavigationManager.navigateTo(
      context: context,
      screen: const RegisterScreen(),
    );
  }
}

class _LodinButton extends StatelessWidget {
  const _LodinButton({
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
