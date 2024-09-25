import 'package:flutter/widgets.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/email_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/name_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/password_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/phone_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/register_screen_body.dart';

class RgisterForm extends StatelessWidget {
  const RgisterForm({
    super.key,
    required this.requestModel,
  });

  final RegisterScreenBodyState requestModel;

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Column _body() {
    return Column(
    children: [
      EmailField(controller: requestModel.emailController),
      const SizedBox(height: 15),
      PasswordField(
        controller: requestModel.passwordController,
   
      ),
      const SizedBox(height: 10),
      NameField(controller: requestModel.nameController),
      const SizedBox(height: 10),
      PhoneField(controller: requestModel.phoneController),
    ],
  );
  }
}
