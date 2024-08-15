import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Features/home/domain/use_case/login_use_case/login_use_case.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';

import '../../../../../core/widgets/cache_helper.dart';
import '../../../../../core/widgets/constants.dart';
import '../../../../../core/widgets/reusable_widgets.dart';
import '../../../../../models/login_model.dart';
import '../../../../../screens/layout_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(AppInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginUseCase? loginUseCase;

  Future<void> userLogin({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    emit(AppLoginLoadingState());

    var result = await loginUseCase?.call(email, password);
    if (!context!.mounted) return;
    ShopCubit.get(context).currentIndex = 0;
    result?.fold(
      (failure) {
        emit(AppLoginErrorState(failure.message));
        print(failure.message);
      },
      (loginModel) {
        print('Login Success');
        emit(AppLoginSuccessState(loginModel));

        Fluttertoast.showToast(
          msg: loginModel.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        CacheHelper.saveData(
          key: 'token',
          value: loginModel.data!.token,
        );
        token = loginModel.data!.token!;

        ShopCubit.get(context).getHomeData();
        ShopCubit.get(context).getCartItems();
        ShopCubit.get(context).getFavorites();
        navigateAndFinish(context: context, screen: const LayoutScreen());
        //ShopCubit.get(context).getFavorites(); // Fetch favorites after login
      },
    );
  }

  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(AppLoginLoadingState());
  //   DioHelper.postData(
  //     url: loginEndPoint,
  //     data: {
  //       'email': email,
  //       'password': password,
  //     },
  //     token: token,
  //   ).then((value) {
  //     print(value.data);
  //     loginModel = LoginModel.fromJson(value.data);
  //     print(loginModel!.message);
  //     print(loginModel!.status);
  //     //print(loginModel!.data!.token);
  //     emit(AppLoginSuccessState(
  //       loginModel!,
  //     ));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(AppLoginErrorState(error.toString()));
  //   });
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AppChangePasswordVisibilityState());
  }
}
