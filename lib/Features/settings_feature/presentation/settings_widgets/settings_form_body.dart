import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/name_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/phone_text_field.dart';
import 'package:shop_app/Features/settings_feature/presentation/screens/settings_screen.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/sign_out_elevated_botton.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/update_elevated_borron.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/functions/toast_function.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../authentication_feature/presentation/screens/login_screen.dart';
import '../../../authentication_feature/presentation/widgets/email_text_field.dart';
import '../cubit/user_info_cubit/sign_out_cubit.dart';
import '../cubit/user_info_cubit/update_user_data_cubit.dart';

class SettingsFormBody extends StatelessWidget {
  const SettingsFormBody({
    super.key,
    required this.userState,
  });

  final SettingsScreenState userState;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignOutCubit, SignOutState>(
      listener: _signOutListener,
      child: BlocConsumer<UpdateUserDataCubit, UpdateUserDataState>(
        listener: _updateListener,
        builder: (context, state) => _buildFormBody(context, state),
      ),
    );
  }

  Widget _buildFormBody(BuildContext context, UpdateUserDataState state) {
    return Column(
      children: [
        NameField(controller: userState.nameController),
        const SizedBox(height: 20.0),
        EmailField(controller: userState.emailController),
        const SizedBox(height: 20.0),
        PhoneField(controller: userState.phoneController),
        const SizedBox(height: 20.0),
        const SignOutElevatedBotton(),
        const SizedBox(height: 20.0),
        UpdateElevatedBotton(
          formKey: userState.formKey,
          userState: userState,
        ),
      ],
    );
  }

  void _updateListener(BuildContext context, UpdateUserDataState state) {
    if (state is UpdateUserDataError) {
      showToast(
        message: state.error,
      );
    } else if (state is UpdateUserDataSuccess) {
      _handleUpdateSuccess(context);
    }
  }

  void _handleUpdateSuccess(BuildContext context) {
    UserInfoCubit.get(context).getUserData();
    showToast(
      message: 'Data updated successfully',
      color: ColorController.greenAccent,
    );
  }

  void _signOutListener(BuildContext context, SignOutState state) {
    if (state is UserSignOutSuccess) {
      NavigationManager.navigateAndFinish(
        context: context, 
        screen: const LoginScreen(),
      );
    } else if (state is UserSignOutError) {
      showToast(
        message: state.error,
      );
    }
  }
}
