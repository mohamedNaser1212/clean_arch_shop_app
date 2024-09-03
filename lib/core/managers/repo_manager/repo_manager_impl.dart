import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../errors_manager/failure.dart';
import '../../errors_manager/internet_failure.dart';
import '../../errors_manager/server_failure.dart';
import '../internet_manager/internet_manager.dart';
import 'repo_manager.dart';

class RepoManagerImpl extends RepoManager {
  final InternetManager internetManager;

  RepoManagerImpl({
    required this.internetManager,
  });

  @override
  Future<Either<Failure, T>> call<T>({
    required Future<T> Function() action,
  }) async {
    try {
      final isConnected = await internetManager.checkConnection();
      if (!isConnected) {
        return left(
          InternetFailure.fromConnectionStatus(
            InternetConnectionStatus.disconnected,
          ),
        );
      }
      final result = await action();
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
