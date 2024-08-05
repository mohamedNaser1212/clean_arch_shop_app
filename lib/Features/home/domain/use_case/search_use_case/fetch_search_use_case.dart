import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/use_case/search_use_case/super_fetch_search_use_case.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../models/SearchModel.dart';
import '../../../data/repos/search_repo/search_repo.dart';

class FetchSearchUseCase extends SuperFetchSearchUseCase<SearchProduct> {
  final SearchRepo searchRepo;

  FetchSearchUseCase(this.searchRepo);

  @override
  Future<Either<Failure, List<SearchProduct>>> call(String text) {
    return searchRepo.search(text);
  }
}
