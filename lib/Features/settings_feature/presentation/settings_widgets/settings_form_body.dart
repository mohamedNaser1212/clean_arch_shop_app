import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/settings_feature/presentation/screen/settings_screen.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/sign_out_elevated_botton_widget.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/update_elevated_borron.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';
import 'package:shop_app/core/widgets/form_fields/email_text_field.dart';
import 'package:shop_app/core/widgets/form_fields/name_text_field.dart';
import 'package:shop_app/core/widgets/form_fields/phone_text_field.dart';
import '../../../../core/functions/navigations_function.dart';
import '../../../../core/functions/toast_function.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../authentication_feature/presentation/screens/login_screen.dart';
import '../cubit/user_info_cubit/sign_out_cubit/sign_out_cubit.dart';
import '../cubit/user_info_cubit/update_user_data_cubit/update_user_data_cubit.dart';

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
        builder: _builder,
      ),
    );
  }

  Widget _builder(context, state) {
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
          userState: userState,
        ),
      ],
    );
  }

  void _updateListener(BuildContext context, UpdateUserDataState state) {
    if (state is UpdateUserDataError) {
      ToastFunction.showToast(
        message: state.error,
      );
    } else if (state is UpdateUserDataSuccess) {
      UserInfoCubit.get(context).getUserData();
      ToastFunction.showToast(
        message: 'Data updated successfully',
        color: ColorController.greenAccent,
      );
    }
  }

  void _signOutListener(BuildContext context, SignOutState state) {
    if (state is UserSignOutSuccess) {
      NavigationFunctions.navigateAndFinish(
        context: context,
        screen: const LoginScreen(),
      );
    } else if (state is UserSignOutError) {
      ToastFunction.showToast(
        message: state.error,
      );
    }
  }
}
