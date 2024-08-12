import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/domain/use_case/register_use_case/register_use_case.dart';
import 'package:shop_app/Features/home/presentation/manager/register_cubit/register_cubit.dart';

import '../Features/home/data/repos/register_repo/register_repo.dart';
import '../core/utils/funactions/set_up_service_locator.dart';
import '../core/widgets/constants.dart';
import '../core/widgets/reusable_widgets.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        RegisterUseCase(
          getIt.get<RegisterRepo>(),
        ),
      ),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          // if (state is RegisterSuccessState) {
          //   if (state.loginModel.status!) {
          //     CacheHelper.saveData(
          //       key: 'token',
          //       value: state.loginModel.data!.token,
          //     );
          //     token = state.loginModel.data!.token!;
          //     navigateAndFinish(context: context, screen: const LayoutScreen());
          //     Fluttertoast.showToast(
          //       msg: 'Register Success',
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.BOTTOM,
          //       timeInSecForIosWeb: 1,
          //       backgroundColor: Colors.green,
          //       textColor: Colors.white,
          //       fontSize: 16.0,
          //     );
          //   } else {
          //     Fluttertoast.showToast(
          //       msg: state.loginModel.message!,
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.BOTTOM,
          //       timeInSecForIosWeb: 1,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0,
          //     );
          //   }
          // }
        },
        builder: (context, state) {
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        reusableTextFormField(
                          label: 'Email',
                          onTap: () {},
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter an email';
                            }
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          activeColor: defaultLightColor,
                          prefix: const Icon(Icons.email_rounded),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        reusableTextFormField(
                          label: 'password',
                          onTap: () {},
                          onSubmit: (String? value) {},
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                          },
                          controller: passwordController,
                          obscure: RegisterCubit.get(context).obsecurePassword,
                          keyboardType: TextInputType.visiblePassword,
                          activeColor: defaultLightColor,
                          prefix: const Icon(
                            Icons.key_rounded,
                          ),
                          suffix: IconButton(
                            onPressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisability();
                            },
                            icon: Icon(
                                RegisterCubit.get(context).suffixPasswordIcon),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        reusableTextFormField(
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
                        const SizedBox(
                          height: 10,
                        ),
                        reusableTextFormField(
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Row(
                            children: [
                              const Text('Already have an account ? '),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text('Login Now')),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => reusableElevatedButton(
                              label: 'Register',
                              backColor: defaultLightColor,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    context: context,
                                  );
                                }
                              },
                            ),
                            fallback: (context) =>
                                const CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
