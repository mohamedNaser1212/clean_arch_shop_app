import '../../../../../models/login_model.dart';

abstract class UpdateUserDataDataSource {
  Future<LoginModel> getUserData();
}
