import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/settings_feature/presentation/settings_widgets/settings_form.dart';
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

class SettingsFormBody extends StatefulWidget {
  const SettingsFormBody({super.key, required this.formState});

  final SettingsFormState formState;

  @override
  State<SettingsFormBody> createState() => SettingsFormBodyState();
}

class SettingsFormBodyState extends State<SettingsFormBody> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignOutCubit, SignOutState>(
      listener: _signOutListener,
      child: BlocConsumer<UpdateUserDataCubit, UpdateUserDataState>(
        listener: _updateListener,
        builder: (context, state) {
          return BlocConsumer<UserInfoCubit, UserInfoState>(
            listener: (context, state) {
              if (state is GetUserInfoSuccessState) {
                nameController.text = state.userEntity!.name;
                emailController.text = state.userEntity!.email;
                phoneController.text = state.userEntity!.phone;
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  NameField(controller: nameController),
                  const SizedBox(height: 20.0),
                  EmailField(controller: emailController),
                  const SizedBox(height: 20.0),
                  PhoneField(controller: phoneController),
                  const SizedBox(height: 20.0),
                  const SignOutElevatedBotton(),
                  const SizedBox(height: 20.0),
                  UpdateElevatedBotton(
                    formState: widget.formState,
                    formBodyState: this,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _updateListener(BuildContext context, UpdateUserDataState state) {
    if (state is UpdateUserDataError) {
      ToastHelper.showToast(
        message: state.error,
      );
    } else if (state is UpdateUserDataSuccess) {
      UserInfoCubit.get(context).getUserData();
      ToastHelper.showToast(
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
      ToastHelper.showToast(
        message: state.error,
      );
    }
  }
}
