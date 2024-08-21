import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../data/search_model/SearchModel.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<SearchProduct>>> search({
    required String text,
  });
}
