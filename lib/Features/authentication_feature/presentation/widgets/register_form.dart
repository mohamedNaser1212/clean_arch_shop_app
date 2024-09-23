import 'package:flutter/widgets.dart';
import 'package:shop_app/features/authentication_feature/presentation/widgets/email_text_field.dart';
import 'package:shop_app/features/authentication_feature/presentation/widgets/name_text_field.dart';
import 'package:shop_app/features/authentication_feature/presentation/widgets/password_text_field.dart';
import 'package:shop_app/features/authentication_feature/presentation/widgets/phone_text_field.dart';
import 'package:shop_app/features/authentication_feature/presentation/widgets/register_screen_builder.dart';

class RgisterForm extends StatelessWidget {
  const RgisterForm({
    super.key,
    required this.requestModel,
  });

  final RegisterScreenBuilderState requestModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailField(controller: requestModel.emailController),
        const SizedBox(height: 15),
        PasswordField(
          controller: requestModel.passwordController,
          obscure: true,
          onSuffixPressed: () {},
        ),
        const SizedBox(height: 10),
        NameField(controller: requestModel.nameController),
        const SizedBox(height: 10),
        PhoneField(controller: requestModel.phoneController),
      ],
    );
  }
}
