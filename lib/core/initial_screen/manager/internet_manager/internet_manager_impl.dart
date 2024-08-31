import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'internet_manager.dart';

class InternetManagerImpl implements InternetManager {
  @override
  Future<bool> checkConnection() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
