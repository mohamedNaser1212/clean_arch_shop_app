import 'package:flutter/widgets.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/email_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/name_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/password_text_field.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/phone_text_field.dart';

class RgisterForm extends StatelessWidget {
  const RgisterForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.phoneController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailField(controller: emailController),
        const SizedBox(height: 15),
        PasswordField(
          controller: passwordController,
          obscure: true,
          onSuffixPressed: () {},
        ),
        const SizedBox(height: 10),
        NameField(controller: nameController),
        const SizedBox(height: 10),
        PhoneField(controller: phoneController),
      ],
    );
  }
}
