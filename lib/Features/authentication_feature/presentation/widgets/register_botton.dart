import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/data/model/register_request_model.dart';
import 'package:shop_app/Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/dont_have_account_widget.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/register_screen_builder.dart';

import 'package:shop_app/core/widgets/reusable_widgets/reusable_elevated_botton.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
    required this.state,
  }) : super(key: key);

  final RegisterScreenBuilderState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReusableElevatedButton(
            label: 'Register',
            onPressed: () {
              if (state.formKey.currentState!.validate()) {
                RegisterCubit.get(context).userRegister(
                  requestModel: RegisterRequestModel(
                    email: state.emailController.text,
                    password: state.passwordController.text,
                    name: state.nameController.text,
                    phone: state.phoneController.text,
                  ),
                );
              }
            }),
        const SizedBox(height: 10),
        CheckAuthStatusTextWidget(
          onRegisterPressed: () {
            Navigator.pop(context);
          },
          title: 'Already have an account?',
          subtitle: 'Login',
        )
      ],
    );
  }
}
