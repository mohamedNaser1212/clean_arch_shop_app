import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/widgets/loading_indicator.dart';

import '../../../../core/functions/toast_function.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/reusable_widgets/reusable_elevated_botton.dart';
import '../cubit/user_info_cubit/update_user_data_cubit.dart';

class UpdateElevatedBotton extends StatelessWidget {
  const UpdateElevatedBotton(
      {super.key,
      required this.formKey,
      required this.nameController,
      required this.emailController,
      required this.phoneController});

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateUserDataCubit, UpdateUserDataState>(
      builder: (context, updateState) {
        return ConditionalBuilder(
          condition: updateState is! UpdateUserDataLoading,
          builder: (context) => ReusableElevatedButton(
            label: 'Update',
            backColor: ColorController.blueAccentColor,
            textColor: ColorController.buttonTextColor,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final cubit = UpdateUserDataCubit.get(context);
                UpdateUserDataCubit.get(context).userModel =
                    UserInfoCubit.get(context).userEntity;
                if (cubit.checkDataChanges(
                  name: nameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                )) {
                  cubit.updateUserData(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                  );
                } else {
                  showToast(
                    message: 'No changes detected. Your data is up-to-date.',
                    isError: false,
                  );
                }
              }
            },
          ),
          fallback: (context) => const Center(child: LoadingIndicatorWidget()),
        );
      },
    );
  }
}