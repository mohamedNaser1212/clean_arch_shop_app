import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'failure.dart';

class InternetFailure extends Failure {
  const InternetFailure({required super.message});

  factory InternetFailure.fromConnectionStatus(
      InternetConnectionStatus status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        return const InternetFailure(message: 'Connected but facing issues.');
      case InternetConnectionStatus.disconnected:
        return const InternetFailure(message: 'No Internet Connection.');
      default:
        return const InternetFailure(message: 'Unknown internet status.');
    }
  }
}
