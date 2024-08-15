import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/manager/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:shop_app/core/widgets/toast_widget.dart';

import '../Features/home/domain/use_case/get_user_data_use_case/get_user_data_use_case.dart';
import '../core/utils/funactions/set_up_service_locator.dart';
import '../core/widgets/settings_widgets/settings_form.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserDataCubit(getUserDataUseCase: getIt.get<UserDataUseCase>())
            ..getUserData(),
      child: const BlocConsumer<UserDataCubit, GetUserDataState>(
        listener: _listener,
        builder: _buildSettingsForm,
      ),
    );
  }
}

void _listener(BuildContext context, GetUserDataState state) {
  if (state is UpdateUserDataError) {
    showToast(
      message: 'Could not get user data, please try again later',
      isError: true,
    );
  } else if (state is UpdateUserDataSuccess) {
    showToast(
      message: 'Data updated successfully',
      isError: false,
    );
  }
}

Widget _buildSettingsForm(BuildContext context, GetUserDataState state) {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return SettingsForm(
    emailController: emailController,
    nameController: nameController,
    phoneController: phoneController,
    formKey: formKey,
    state: state,
  );
}
