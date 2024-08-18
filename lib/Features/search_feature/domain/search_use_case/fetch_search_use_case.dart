import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../data/search_model/SearchModel.dart';
import '../search_repo/search_repo.dart';

class FetchSearchUseCase {
  final SearchRepo searchRepo;

  FetchSearchUseCase(this.searchRepo);

  Future<Either<Failure, List<SearchProduct>>> call(String text) {
    return searchRepo.search(text);
  }
}
