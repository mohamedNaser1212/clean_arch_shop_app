import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/login_form.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_form.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_form_body.dart';
import 'package:shop_app/core/widgets/reusable_elevated_botton.dart';

import '../../Features/authentication_feature/data/model/login_request_model.dart';
import '../../Features/authentication_feature/data/model/register_request_model.dart';
import '../../Features/authentication_feature/presentation/cubit/login_cubit/login_cubit.dart';
import '../../Features/authentication_feature/presentation/cubit/register_cubit/register_cubit.dart';
import '../../Features/authentication_feature/presentation/widgets/register_screen_body.dart';
import '../../Features/settings_feature/data/update_user_request_model.dart';
import '../../Features/settings_feature/presentation/cubit/user_info_cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../Features/settings_feature/presentation/cubit/user_info_cubit/update_user_data_cubit/update_user_data_cubit.dart';
import '../../Features/settings_feature/presentation/screen/settings_screen.dart';
import '../functions/toast_function.dart';
import '../payment_gate_way/cubit/payment_cubit.dart';
import '../user_info/cubit/user_info_cubit.dart';
import '../utils/styles/color_manager.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton._({
    required this.onPressed,
    required this.label,
  });

  final VoidCallback onPressed;
  final String label;
  Color? backColor;

  factory CustomElevatedButton.loginButton({
    required LoginFornState state,
    required BuildContext context,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _loginAction(state, context),
      label: 'Login',
    );
  }

  factory CustomElevatedButton.registerButton({
    required BuildContext context,
    required RegisterScreenBodyState state,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _registerAction(context, state),
      label: 'Register',
    );
  }

  factory CustomElevatedButton.checkOutButton({
    required BuildContext context,
    required num total,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _checkoutAction(context, total),
      label: 'CheckOut',
    );
  }

  factory CustomElevatedButton.updateButton({
    required BuildContext context,
    required SettingsFormState userState,
    required SettingsFormBodyState formBodyState,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _updateAction(
        context: context,
        userState: userState,
        formBodyState: formBodyState,
      ),
      label: 'Update',
    );
  }

  factory CustomElevatedButton.signOutButton({
    required BuildContext context,
  }) {
    return CustomElevatedButton._(
      onPressed: () => _signOutAction(context),
      label: 'Sign Out',
    );
  }

  static void _loginAction(LoginFornState state, BuildContext context) {
    if (state.widget.formKey.currentState!.validate()) {
      LoginCubit.get(context).login(
        requestModel: LoginRequestModel(
          email: state.widget.emailController.text,
          password: state.widget.passwordController.text,
        ),
      );
    }
  }

  static void _registerAction(
      BuildContext context, RegisterScreenBodyState state) {
    if (state.formKey.currentState!.validate()) {
      RegisterCubit.get(context).register(
        requestModel: RegisterRequestModel(
          email: state.emailController.text,
          password: state.passwordController.text,
          name: state.nameController.text,
          phone: state.phoneController.text,
        ),
      );
    }
  }

  static void _checkoutAction(BuildContext context, num total) {
    PaymentCubit.get(context).getClientSecret(
      amount: total.toInt(),
      currency: 'EGP',
    );
  }

  static void _updateAction({
    required BuildContext context,
    required SettingsFormState userState,
    required SettingsFormBodyState formBodyState,
  }) {
    if (userState.formKey.currentState!.validate()) {
      final cubit = UpdateUserDataCubit.get(context);
      UpdateUserDataCubit.get(context).userEntity =
          UserInfoCubit.get(context).userEntity;
      if (cubit.checkDataChanges(
        name: formBodyState.nameController.text,
        email: formBodyState.emailController.text,
        phone: formBodyState.phoneController.text,
      )) {
        cubit.updateUserData(
          updateUserRequestModel: UpdateUserRequestModel(
            name: formBodyState.nameController.text,
            email: formBodyState.emailController.text,
            phone: formBodyState.phoneController.text,
          ),
        );
      } else {
        ToastHelper.showToast(
          message: 'No changes detected. Your data is up-to-date.',
          color: ColorController.greenAccent,
        );
      }
    }
  }

  static void _signOutAction(BuildContext context) {
    SignOutCubit.get(context).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return ReusableElevatedButton(
      label: label,
      backColor: backColor ?? ColorController.blueAccent,
      onPressed: onPressed,
      textColor: ColorController.whiteColor,
    );
  }
}
