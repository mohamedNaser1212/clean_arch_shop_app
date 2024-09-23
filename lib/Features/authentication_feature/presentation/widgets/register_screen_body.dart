import 'package:flutter/material.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/register_botton.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/register_form.dart';
import 'package:shop_app/core/utils/styles_manager/text_styles_manager.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({
    super.key,
  });

  @override
  State<RegisterScreenBody> createState() => RegisterScreenBodyState();
}

class RegisterScreenBodyState extends State<RegisterScreenBody> {
  late final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'REGISTER',
                style: StylesManager.textStyle30,
              ),
              const SizedBox(height: 15),
              RgisterForm(
                requestModel: this,
              ),
              const SizedBox(height: 10),
              RegisterButton(
                state: this,
              )
            ],
          ),
        ),
      ),
    );
  }
}
