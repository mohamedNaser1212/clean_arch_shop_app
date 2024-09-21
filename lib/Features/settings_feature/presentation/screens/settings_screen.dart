import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/Features/settings_feature/presentation/cubit/user_info_cubit/sign_out_cubit.dart';
import 'package:shop_app/Features/settings_feature/presentation/cubit/user_info_cubit/update_user_data_cubit.dart';
import 'package:shop_app/core/functions/navigations_functions.dart';

import '../../../../core/functions/toast_function.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../domain/settings_use_case/update_user_data_use_case.dart';
import '../settings_widgets/settings_form.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateUserDataCubit(
            updateUserDataUseCase: getIt.get<UpdateUserDataUseCase>(),
          ),
        ),
      ],
      child: BlocConsumer<SignOutCubit, SignOutState>(
        listener: (context, state) {
          if (state is UserSignOutSuccess) {
            NavigationManager.navigateAndFinish(
                context: context, screen: LoginScreen());
          } else if (state is UserSignOutError) {
            showToast(message: state.error, isError: true);
          }
        },
        builder: (context, state) {
          return BlocConsumer<UpdateUserDataCubit, UpdateUserDataState>(
            listener: (context, state) {
              if (state is UpdateUserDataError) {
                showToast(message: state.error, isError: true);
              }
            },
            builder: (context, state) {
              return BlocBuilder<UpdateUserDataCubit, UpdateUserDataState>(
                builder: (context, state) {
                  if (state is UpdateUserDataSuccess) {
                    UserInfoCubit.get(context).getUserData();
                    showToast(
                        message: 'Data updated successfully', isError: false);
                  }
                  return BlocConsumer<UserInfoCubit, UserInfoState>(
                    listener: (context, userState) {
                      if (userState is GetUserInfoSuccessState) {
                        _showUserData(context);
                      }
                    },
                    builder: (context, userState) {
                      return SettingsForm(
                        emailController: emailController,
                        nameController: nameController,
                        phoneController: phoneController,
                        formKey: formKey,
                        state: userState,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showUserData(BuildContext context) {
    var userEntity = UserInfoCubit.get(context).userEntity;
    if (userEntity != null) {
      nameController.text = userEntity.name;
      emailController.text = userEntity.email;
      phoneController.text = userEntity.phone;
    }
  }
}
