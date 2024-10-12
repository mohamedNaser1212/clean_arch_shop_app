import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/settings_feature/data/update_user_request_model.dart';
import 'package:shop_app/Features/settings_feature/domain/user_entity/user_entity.dart';

import '../../../../domain/settings_use_case/update_user_data_use_case.dart';

part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  UpdateUserDataCubit({
    required this.updateUserDataUseCase,
  }) : super(UpdateUserDataState());

  static UpdateUserDataCubit get(context) => BlocProvider.of(context);

  UserEntity? userEntity;
  final UpdateUserDataUseCase updateUserDataUseCase;

  bool checkDataChanges({
    required String name,
    required String email,
    required String phone,
  }) {
    return userEntity != null &&
        (name != userEntity!.name ||
            email != userEntity!.email ||
            phone != userEntity!.phone);
  }

  Future<void> updateUserData({
    required UpdateUserRequestModel updateUserRequestModel,
  }) async {
    emit(UpdateUserDataLoading());
    final result = await updateUserDataUseCase.call(
      updateUserRequestModel: updateUserRequestModel,
    );
    result.fold(
      (failure) {
        emit(UpdateUserDataError(error: failure.message));
      },
      (user) {
        userEntity = user;
        // getUserData();
        emit(UpdateUserDataSuccess(userEntity: user));
      },
    );
  }
}
