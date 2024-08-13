import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/reusable_widgets.dart';

import '../../Features/home/presentation/manager/get_user_data_cubit/get_user_data_cubit.dart';

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
    final userModel = UserDataCubit.get(context).userModel;
    if (userModel != null) {
      nameController.text = userModel.name ?? '';
      emailController.text = userModel.email ?? '';
      phoneController.text = userModel.phone ?? '';
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            if (state is GetUserDataLoading) const LinearProgressIndicator(),
            reusableTextFormField(
              label: 'Name',
              controller: nameController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name must not be empty';
                }
                return null;
              },
              prefix: const Icon(Icons.person),
              onTap: () {},
            ),
            const SizedBox(height: 20.0),
            reusableTextFormField(
              label: 'Email Address',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email must not be empty';
                }
                return null;
              },
              prefix: const Icon(Icons.email),
              onTap: () {},
            ),
            const SizedBox(height: 20.0),
            reusableTextFormField(
              label: 'Phone',
              controller: phoneController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Phone must not be empty';
                }
                return null;
              },
              prefix: const Icon(Icons.phone),
              onTap: () {},
            ),
            const SizedBox(height: 20.0),
            reusableElevatedButton(
              label: 'LOGOUT',
              function: () {
                UserDataCubit.get(context).signOut(context);
              },
            ),
            const SizedBox(height: 20.0),
            reusableElevatedButton(
              label: 'UPDATE',
              backColor: Colors.red,
              function: () {
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
