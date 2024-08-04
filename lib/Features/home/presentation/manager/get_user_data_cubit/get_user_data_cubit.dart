import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/domain/use_case/get_user_data_use_case/super_get_user_data_use_case.dart';

import '../../../../../models/login_model.dart';

part 'get_user_data_state.dart';

class UserDataCubit extends Cubit<GetUserDataState> {
  final SuperGetUserDataUseCase getUserDataUseCase;

  UserDataCubit({required this.getUserDataUseCase})
      : super(GetUserDataInitial());

  static UserDataCubit get(context) => BlocProvider.of(context);

  LoginModel? userModel;

  void getUserData() async {
    emit(GetUserDataLoading());
    final result = await getUserDataUseCase.GetUserData();
    result.fold(
      (failure) {
        emit(GetUserDataError(failure.toString()));
      },
      (user) {
        userModel = user;
        emit(GetUserDataSuccess(user));
      },
    );
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(GetUserDataLoading());
    final result = await getUserDataUseCase.UpdateUserData(
      name: name,
      email: email,
      phone: phone,
    );
    result.fold(
      (failure) {
        emit(UpdateUserDataError(failure.toString()));
      },
      (user) {
        userModel = user;
        emit(UpdateUserDataSuccess(user));
      },
    );
  }
}
