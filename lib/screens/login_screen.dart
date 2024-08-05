import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/core/widgets/cache_helper.dart';
import 'package:shop_app/screens/layout_screen.dart';
import 'package:shop_app/screens/register_screen.dart';

import '../Features/home/data/repos/login_repo/login_repo.dart';
import '../Features/home/domain/use_case/login_use_case/login_use_case.dart';
import '../Features/home/presentation/manager/login_cubit/login_cubit.dart';
import '../core/utils/funactions/set_up_service_locator.dart';
import '../core/widgets/reusable_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        LoginUseCase(
          getIt.get<LoginRepo>(),
        ),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is AppLoginSuccessState) {
            if (state.loginModel.status!) {
              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              );
              navigateAndFinish(context: context, screen: LayoutScreen());
            } else {
              print('before toast');
              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              print('after toast');
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN Screen',
                          // style:
                          //     Theme.of(context).textTheme.headline4?.copyWith(
                          //           color: Colors.black,
                          //         ),
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        reusableTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icon(Icons.email_outlined),
                          onTap: () {},
                          //suffixPressed: () {  },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        reusableTextFormField(
                          // suffix: LoginCubit.get(context).suffix,

                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            }
                            return null;
                          },
                          label: 'Password',
                          obscure: LoginCubit.get(context).isPassword,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          onTap: () {},
                          prefix: const Icon(Icons.lock_outline),
                          //   suffixPressed: () {
                          //   LoginCubit.get(context).changePasswordVisibility();
                          // },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! AppLoginLoadingState,
                          builder: (context) => reusableElevatedButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            label: 'login',
                            width: double.infinity,
                            height: 50,
                            radius: 20,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(
                                      context: context,
                                      screen: RegisterScreen());
                                },
                                child: const Text('Register Now')),
                          ],
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
