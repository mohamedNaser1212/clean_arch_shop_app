import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_elevated_botton.dart';

import '../../Features/authentication_feature/data/model/login_request_model.dart';
import '../../Features/authentication_feature/data/model/register_request_model.dart';
import '../../Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import '../../Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import '../../Features/authentication_feature/presentation/screens/login_screen.dart';
import '../../Features/authentication_feature/presentation/widgets/register_screen_body.dart';
import '../../Features/settings_feature/data/update_user_request_model.dart';
import '../../Features/settings_feature/presentation/cubit/user_info_cubit/sign_out_cubit.dart';
import '../../Features/settings_feature/presentation/cubit/user_info_cubit/update_user_data_cubit.dart';
import '../../Features/settings_feature/presentation/screens/settings_screen.dart';
import '../functions/toast_function.dart';
import '../user_info/cubit/user_info_cubit.dart';
import '../utils/styles_manager/color_manager.dart';

class CustomElevatedBotton extends StatelessWidget {
  CustomElevatedBotton._({
    required this.onRegisterPressed,
    required this.label,
    this.backColor,
  });

  final VoidCallback onRegisterPressed;
  final String label;
  Color? backColor;

  factory CustomElevatedBotton.loginButton({
    required LoginScreenState state,
    required BuildContext context,
  }) {
    return CustomElevatedBotton._(
      onRegisterPressed: () {
        if (state.formKey.currentState!.validate()) {
          LoginCubit.get(context).login(
            requestModel: LoginRequestModel(
              email: state.emailController.text,
              password: state.passwordController.text,
            ),
          );
        }
      },
      label: 'Login',
    );
  }

  factory CustomElevatedBotton.registerButton({
    required BuildContext context,
    required RegisterScreenBodyState state,
  }) {
    return CustomElevatedBotton._(
      onRegisterPressed: () {
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
      },
      label: 'Register',
    );
  }
  factory CustomElevatedBotton.updateButton({
    required BuildContext context,
    required SettingsScreenState userState,
    required GlobalKey<FormState> formKey,
  }) {
    return CustomElevatedBotton._(
      onRegisterPressed: () {
        if (formKey.currentState!.validate()) {
          final cubit = UpdateUserDataCubit.get(context);
          UpdateUserDataCubit.get(context).userModel =
              UserInfoCubit.get(context).userEntity;
          if (cubit.checkDataChanges(
            name: userState.nameController.text,
            email: userState.emailController.text,
            phone: userState.phoneController.text,
          )) {
            cubit.updateUserData(
              updateUserRequestModel: UpdateUserRequestModel(
                name: userState.nameController.text,
                email: userState.emailController.text,
                phone: userState.phoneController.text,
              ),
            );
          } else {
            showToast(
              message: 'No changes detected. Your data is up-to-date.',
              color: ColorController.greenAccent,
            );
          }
        }
      },
      label: 'Update',
    );
  }
  factory CustomElevatedBotton.signOutButton({
    required BuildContext context,
  }) {
    return CustomElevatedBotton._(
      onRegisterPressed: () {
        SignOutCubit.get(context).signOut();
      },
      label: 'Sign Out',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReusableElevatedButton(
      label: label,
      backColor: backColor ?? ColorController.blueAccent,
      onPressed: onRegisterPressed,
    );
  }
}
