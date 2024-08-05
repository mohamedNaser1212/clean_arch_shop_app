import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class SuperFetchSearchUseCase<Data> {
  Future<Either<Failure, List<Data>>> call(String text);
}
