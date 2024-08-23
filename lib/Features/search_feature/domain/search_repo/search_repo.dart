import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../data/search_model/search_data.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<SearchProduct>>> search({
    required String text,
  });
}
