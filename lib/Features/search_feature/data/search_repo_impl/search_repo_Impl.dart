import 'package:dartz/dartz.dart';
import 'package:shop_app/core/managers/repo_manager/repo_manager.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../domain/search_repo/search_repo.dart';
import '../search_data_source/search_remote_data_source.dart';
import '../search_model/search_response_model.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchRemoteDataSource searchDataSource;
  final RepoManager repoManager;
  const SearchRepoImpl({
    required this.searchDataSource,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, List<SearchResponseModel>>> search({
    required String text,
  }) async {
    return repoManager.call(
      action: () async {
        final searchResult = await searchDataSource.search(text: text);
        return searchResult;
      },
    );
  }
}
