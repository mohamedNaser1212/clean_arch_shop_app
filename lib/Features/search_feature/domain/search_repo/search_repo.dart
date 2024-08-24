import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../data/search_model/search_response_model.dart';

abstract class SearchRepo {
  const SearchRepo();
  Future<Either<Failure, List<SearchResponseModel>>> search({
    required String text,
  });
}
