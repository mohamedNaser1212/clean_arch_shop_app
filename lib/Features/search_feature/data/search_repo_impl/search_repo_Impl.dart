import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../domain/search_repo/search_repo.dart';
import '../search_data_source/search_remote_data_source.dart';
import '../search_model/SearchModel.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchDataSource searchDataSource;

  const SearchRepoImpl({
    required this.searchDataSource,
  });

  @override
  Future<Either<Failure, List<SearchProduct>>> search({
    required String text,
  }) async {
    return await searchDataSource.search(text: text);
  }
}
