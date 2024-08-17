import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../data/search_model/SearchModel.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<SearchProduct>>> search(String text);
}
