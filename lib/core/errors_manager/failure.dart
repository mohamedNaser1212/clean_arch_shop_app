import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.fromDiorError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectionTimeout:
        return const ServerFailure('Connection timeout with api server');

      case DioErrorType.sendTimeout:
        return const ServerFailure('Send timeout with ApiServer');
      case DioErrorType.receiveTimeout:
        return const ServerFailure('Receive timeout with ApiServer');
      case DioErrorType.badCertificate:
        return const ServerFailure('badCertificate with api server');
      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode!, e.response!.data);
      case DioErrorType.cancel:
        return const ServerFailure('Request to ApiServer was canceld');
      case DioErrorType.connectionError:
        return const ServerFailure('No Internet Connection');
      case DioErrorType.unknown:
        return const ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return const ServerFailure(
          'Your request was not found, please try later');
    } else if (statusCode == 500) {
      return const ServerFailure(
          'There is a problem with server, please try later');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else {
      return const ServerFailure('There was an error , please try again');
    }
  }
}
