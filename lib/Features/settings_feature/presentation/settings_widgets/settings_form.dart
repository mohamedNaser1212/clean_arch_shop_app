import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/settings_feature/presentation/cubit/user_info_cubit/update_user_data_cubit.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';
import 'package:shop_app/core/user_info/cubit/user_info_cubit.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_elevated_botton.dart';
import 'package:shop_app/core/widgets/reusable_widgets/reusable_text_form_field.dart';

import '../../../../core/functions/toast_function.dart';
import '../../../../core/networks/api_manager/api_manager.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../cubit/user_info_cubit/sign_out_cubit.dart';

class SettingsForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;
  final UserInfoState state;

  const SettingsForm({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.formKey,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ReusableTextFormField(
              label: 'Name',
              controller: nameController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name must not be empty';
                }
                return null;
              },
              prefix:
                  const Icon(Icons.person, color: ColorController.iconColor),
            ),
            const SizedBox(height: 20.0),
            ReusableTextFormField(
              label: 'Email Address',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email must not be empty';
                }
                return null;
              },
              prefix: const Icon(Icons.email, color: ColorController.iconColor),
            ),
            const SizedBox(height: 20.0),
            ReusableTextFormField(
              label: 'Phone',
              controller: phoneController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Phone must not be empty';
                }
                return null;
              },
              prefix: const Icon(Icons.phone, color: ColorController.iconColor),
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<SignOutCubit, SignOutState>(
              builder: (context, state) {
                return ConditionalBuilder(
                  condition: state is! UserSignOutLoading,
                  builder: (context) => ReusableElevatedButton(
                    label: 'Sign Out',
                    onPressed: () {
                      SignOutCubit.get(context).signOut(getIt<ApiManager>());
                    },
                    backColor: ColorController.warningColor,
                    textColor: ColorController.buttonTextColor,
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: ColorController.accentColor,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<UpdateUserDataCubit, UpdateUserDataState>(
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
                            message:
                                'No changes detected. Your data is up-to-date.',
                            isError: false,
                          );
                        }
                      }
                    },
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: ColorController.accentColor,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
