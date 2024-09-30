import 'package:dartz/dartz.dart';

import '../../../../core/managers/errors_manager/failure.dart';
import '../../data/search_model/search_model.dart';

abstract class SearchRepo {
  const SearchRepo._();
  Future<Either<Failure, List<SearchModel>>> search({
    required String text,
  });
}
