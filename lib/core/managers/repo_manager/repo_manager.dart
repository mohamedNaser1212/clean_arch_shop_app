import 'package:dartz/dartz.dart';

import '../../errors_manager/failure.dart';

abstract class RepoManager {
  Future<Either<Failure, T>> call<T>({
    required Future<T> Function() action,
  });
}