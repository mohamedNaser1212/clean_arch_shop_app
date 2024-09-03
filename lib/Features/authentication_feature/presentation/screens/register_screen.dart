import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shop_app/Features/authentication_feature/presentation/screens/login_screen.dart';
import 'package:shop_app/core/utils/widgets/custom_title.dart';

import '../../../../core/managers/navigations_manager/navigations_manager.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/user_info/cubit/user_info_cubit.dart';
import '../../../../core/utils/styles_manager/text_styles_manager.dart';
import '../../../../core/utils/widgets/constants.dart';
import '../../../../core/utils/widgets/reusable_widgets_manager/reusable_elevated_botton.dart';
import '../../../../core/utils/widgets/reusable_widgets_manager/reusable_text_form_field.dart';
import '../../../carts_feature/presentation/cubit/carts_cubit.dart';
import '../../../favourites_feature/presentation/cubit/favourites_cubit.dart';
import '../../../home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../../../layout/presentation/screens/layout_screen.dart';
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
  if (state is RegisterSuccessState) {
    Fluttertoast.showToast(
      msg: 'Register Successfully',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // await hiveHelper.saveSingleItem<String>(
    //   'token',
    //   state.loginModel.token,
    //   HiveBoxesNames.kSaveTokenBox,
    // );

    if (context.mounted) {
      ProductsCubit.get(context).homeModel;
      // CartsCubit.get(context).getCartItems();
      // FavouritesCubit.get(context).getFavorites();
      UserInfoCubit.get(context).getUserData();
      FavouritesCubit.get(context).getFavorites();
      CartsCubit.get(context).getCartItems();
      NavigationManager.navigateAndFinish(
          context: context, screen: const LayoutScreen());
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
                      const CustomTitle(
                        style: TitleStyle.style16,
                        title: 'Already have an account? ',
                      ),
                      TextButton(
                        onPressed: () {
                          NavigationManager.navigateAndFinish(
                            context: context,
                            screen: LoginScreen(),
                          );
                        },
                        child: const CustomTitle(
                          style: TitleStyle.styleBold18,
                          title: 'Login Now',
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
