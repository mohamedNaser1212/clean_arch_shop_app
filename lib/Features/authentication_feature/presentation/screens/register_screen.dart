import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/register_use_case.dart';

import '../../../../core/managers/navigations_manager/navigations_manager.dart';
import '../../../../core/managers/reusable_widgets_manager/reusable_elevated_botton.dart';
import '../../../../core/managers/reusable_widgets_manager/reusable_text_form_field.dart';
import '../../../../core/networks/Hive_manager/hive_boxes_names.dart';
import '../../../../core/networks/Hive_manager/hive_helper.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/styles_manager/text_styles_manager.dart';
import '../../../../core/utils/widgets/constants.dart';
import '../../../carts_feature/presentation/cubit/carts_cubit.dart';
import '../../../favourites_feature/presentation/cubit/favourites_cubit.dart';
import '../../../home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../../../layout/presentation/screens/layout_screen.dart';
import '../../../settings_feature/presentation/cubit/user_info_cubit/user_data_cubit.dart';
import '../../domain/authentication_repo/authentication_repo.dart';
import '../cubit/register_cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        RegisterUseCase(
          authenticationRepo: getIt.get<AuthenticationRepo>(),
        ),
      ),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: _listener,
        builder: (context, state) => _buildRegisterScreen(context, state),
      ),
    );
  }
}

Future<void> _listener(BuildContext context, RegisterState state) async {
  final hiveHelper = getIt.get<HiveHelper>();

  if (state is RegisterSuccessState) {
    Fluttertoast.showToast(
      msg: state.loginModel.message!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    await hiveHelper.saveSingleItem<String>(
      'token',
      state.loginModel.token,
      HiveBoxesNames.kSaveTokenBox,
    );

    if (context.mounted) {
      GetProductsCubit.get(context).getProductsData(context: context);
      CartsCubit.get(context).getCartItems();
      FavouritesCubit.get(context).getFavorites();
      UserDataCubit.get(context).getUserData();
      navigateAndFinish(context: context, screen: const LayoutScreen());
    }
  } else if (state is RegisterErrorState) {
    Fluttertoast.showToast(
      msg: state.message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

Widget _buildRegisterScreen(BuildContext context, RegisterState state) {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'REGISTER',
                  style: StylesManager.textStyle30,
                ),
                const SizedBox(height: 15),
                ReusableTextFormField(
                  label: 'Email',
                  onTap: () {},
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  activeColor: defaultLightColor,
                  prefix: const Icon(Icons.email_rounded),
                ),
                const SizedBox(height: 10),
                ReusableTextFormField(
                  label: 'Password',
                  onTap: () {},
                  onSubmit: (String? value) {
                    return null;
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscure: RegisterCubit.get(context).obsecurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  activeColor: defaultLightColor,
                  prefix: const Icon(Icons.key_rounded),
                  suffix: IconButton(
                    onPressed: () {
                      // RegisterCubit.get(context).changePasswordVisibility();
                    },
                    icon: Icon(RegisterCubit.get(context).suffixPasswordIcon),
                  ),
                ),
                const SizedBox(height: 10),
                ReusableTextFormField(
                  label: 'Name',
                  onTap: () {},
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Name must not be empty';
                    }
                    return null;
                  },
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  activeColor: defaultLightColor,
                  prefix: const Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                ReusableTextFormField(
                  label: 'Phone',
                  onTap: () {},
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Phone must not be empty';
                    }
                    return null;
                  },
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  activeColor: defaultLightColor,
                  prefix: const Icon(Icons.phone),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      const Text('Already have an account? '),
                      TextButton(
                        onPressed: () {
                          // Navigate to Login Screen
                        },
                        child: const Text(
                          'Login Now',
                          style: StylesManager.textStyle24,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ConditionalBuilder(
                    condition: state is! RegisterLoadingState,
                    builder: (context) => ReusableElevatedButton(
                      label: 'Register',
                      backColor: defaultLightColor,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          RegisterCubit.get(context).userRegister(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                    ),
                    fallback: (context) => const CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
