import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/login_use_case.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';

import '../../../../../core/navigations_manager/navigations_manager.dart';
import '../../../../../core/utils/widgets/cache_helper.dart';
import '../../../../authentication_feature/data/authentication_models/authentication_model.dart';
import '../../../../home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../../../../home/presentation/screens/layout_screen.dart';

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

    var result = await loginUseCase?.call(email: email, password: password);
    if (!context!.mounted) return;
    GetProductsCubit.get(context).currentIndex = 0;
    result?.fold(
      (failure) {
        emit(AppLoginErrorState(failure.message));
        print(failure.message);
      },
      (loginModel) async {
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
        await HiveHelper.saveData(key: 'token', value: loginModel.data!.token);
        // final token = loginModel.data!.token!;
        //   await CacheHelper.saveData(key: 'token', value: token);
        // print(token);

        if (context.mounted) {
          GetProductsCubit.get(context).getProductsData(
            context: context,
          );
          CartsCubit.get(context).getCartItems();
          FavouritesCubit.get(context).getFavorites();
          navigateAndFinish(context: context, screen: const LayoutScreen());
        }
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
