import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  const Failure({
    required this.message,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
  });

  factory ServerFailure.fromDiorError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectionTimeout:
        return const ServerFailure(
            message: 'Connection timeout with api server');

      case DioErrorType.sendTimeout:
        return const ServerFailure(message: 'Send timeout with ApiServer');
      case DioErrorType.receiveTimeout:
        return const ServerFailure(message: 'Receive timeout with ApiServer');
      case DioErrorType.badCertificate:
        return const ServerFailure(message: 'badCertificate with api server');
      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode!, e.response!.data);
      case DioErrorType.cancel:
        return const ServerFailure(message: 'Request to ApiServer was canceld');
      case DioErrorType.connectionError:
        return const ServerFailure(message: 'No Internet Connection');
      case DioErrorType.unknown:
        return const ServerFailure(
            message: 'Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return const ServerFailure(
          message: 'Your request was not found, please try later');
    } else if (statusCode == 500) {
      return const ServerFailure(
          message: 'There is a problem with server, please try later');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(message: response['error']['message']);
    } else {
      return const ServerFailure(
          message: 'There was an error , please try again');
    }
  }
}
