import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/user_info/domain/use_cases/get_user_info_use_case.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/widgets/reusable_widgets_manager/toast_function.dart';
import '../../../authentication_feature/presentation/screens/login_screen.dart';
import '../../domain/settings_use_case/update_user_data_use_case.dart';
import '../../domain/settings_use_case/user_sign_out_use_case.dart';
import '../cubit/user_info_cubit/user_data_cubit.dart';
import '../settings_widgets/settings_form.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDataCubit(
          getInfoUserDataUseCase: getIt.get<GetUserInfoUseCase>(),
          updateUserDataUseCase: getIt.get<UpdateUserDataUseCase>(),
          userSignOutUseCase: getIt.get<UserSignOutUseCase>())
        ..getUserData(),
      child: BlocConsumer<UserDataCubit, GetUserDataState>(
        listener: _listener,
        builder: (context, state) {
          return _buildSettingsForm(
            context: context,
            state: state,
            nameController: nameController,
            emailController: emailController,
            phoneController: phoneController,
            formKey: formKey,
          );
        },
      ),
    );
  }

  Widget _buildSettingsForm({
    required BuildContext context,
    required GetUserDataState state,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required GlobalKey<FormState> formKey,
  }) {
    final userModel = UserDataCubit.get(context).userModel;
    if (userModel != null) {
      nameController.text = userModel.name!;
      emailController.text = userModel.email!;
      phoneController.text = userModel.phone!;
    }

    return SettingsForm(
      emailController: emailController,
      nameController: nameController,
      phoneController: phoneController,
      formKey: formKey,
      state: state,
    );
  }

  static void _listener(BuildContext context, GetUserDataState state) {
    if (state is UpdateUserDataError) {
      showToast(
        message: state.error,
        isError: true,
      );
    } else if (state is UpdateUserDataSuccess) {
      showToast(
        message: 'Data updated successfully',
        isError: false,
      );
    } else if (state is UserSignOutSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else if (state is UserSignOutError) {
      showToast(
        message: state.error,
        isError: true,
      );
    }
  }
}
