import 'package:flutter/material.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';
import 'package:shop_app/core/utils/api_services/api_service_interface.dart';

import '../../../../core/utils/styles/color_manager.dart';
import '../../../../core/utils/widgets/reusable_widgets.dart';
import '../cubit/user_info_cubit/user_data_cubit.dart';

class SettingsForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;
  final GetUserDataState state;

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
            if (state is GetUserDataLoading)
              const LinearProgressIndicator(
                backgroundColor: ColorController.accentColor,
              ),
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
              onTap: () {},
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
              onTap: () {},
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
              onTap: () {},
            ),
            const SizedBox(height: 20.0),
            ReusableElevatedButton(
              label: 'Sign Out',
              onPressed: () {
                UserDataCubit.get(context)
                    .signOut(context, getIt.get<ApiServiceInterface>());
              },
              backColor: ColorController.warningColor,
              textColor: ColorController.buttonTextColor,
            ),
            const SizedBox(height: 20.0),
            ReusableElevatedButton(
              label: 'Update',
              backColor: ColorController.blueAccentColor,
              textColor: ColorController.buttonTextColor,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  UserDataCubit.get(context).updateUserData(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
