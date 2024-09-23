import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/data/model/login_request_model.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/login_use_case.dart';
import 'package:shop_app/Features/authentication_feature/presentation/cubit/login_cubit/login_state.dart';
import 'package:shop_app/core/user_info/domain/use_cases/get_user_info_use_case.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final GetUserInfoUseCase userDataUseCase;

  LoginCubit({
    required this.loginUseCase,
    required this.userDataUseCase,
  }) : super(LoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login({
    required LoginRequestModel requestModel,
  }) async {
    emit(LoginLoadingState());

    final result = await loginUseCase.call(requestModel: requestModel);
    result.fold(
      (failure) {
        emit(LoginErrorState(error: failure.message));
      },
      (success) async {
        emit(LoginSuccessState(userModel: success));
      },
    );
  }
}
