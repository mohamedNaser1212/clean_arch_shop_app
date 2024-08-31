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

  factory ServerFailure.fromDiorError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
            message: 'Connection timeout with api server');

      case DioExceptionType.sendTimeout:
        return const ServerFailure(message: 'Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(message: 'Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return const ServerFailure(message: 'badCertificate with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode!, e.toString());
      case DioExceptionType.cancel:
        return const ServerFailure(message: 'Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return const ServerFailure(message: 'No Internet Connection');
      case DioExceptionType.unknown:
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
