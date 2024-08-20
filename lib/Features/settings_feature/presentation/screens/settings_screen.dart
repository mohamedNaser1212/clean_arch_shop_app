import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/widgets/toast_widget.dart';
import '../../domain/settings_use_case/get_user_data_use_case/update_user_data_use_case.dart';
import '../../domain/settings_use_case/get_user_data_use_case/user_data_use_case.dart';
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
          getUserDataUseCase: getIt.get<UserDataUseCase>(),
          updateUserDataUseCase: getIt.get<UpdateUserDataUseCase>())
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

  static void _listener(BuildContext context, GetUserDataState state) {
    if (state is UpdateUserDataError) {
      showToast(
        message: 'Could not get user data, pleaSe try again later',
        isError: true,
      );
    } else if (state is UpdateUserDataSuccess) {
      showToast(
        message: 'Data updated successfully',
        isError: false,
      );
    }
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
      nameController.text = userModel.name;
      emailController.text = userModel.email;
      phoneController.text = userModel.phone;
    }

    return SettingsForm(
      emailController: emailController,
      nameController: nameController,
      phoneController: phoneController,
      formKey: formKey,
      state: state,
    );
  }

  // @override
  // void dispose() {
  //   nameController.dispose();
  //   emailController.dispose();
  //   phoneController.dispose();
  //   super.dispose();
  // }
}
