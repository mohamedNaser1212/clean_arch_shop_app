import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/search_feature/domain/search_use_case/super_fetch_search_use_case.dart';

import '../../../../../core/errors/failure.dart';
import '../../data/search_model/SearchModel.dart';
import '../search_repo/search_repo.dart';

class FetchSearchUseCase extends SuperFetchSearchUseCase<SearchProduct> {
  final SearchRepo searchRepo;

  FetchSearchUseCase(this.searchRepo);

  @override
  Future<Either<Failure, List<SearchProduct>>> call(String text) {
    return searchRepo.search(text);
  }
}
