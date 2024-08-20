import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../domain/search_repo/search_repo.dart';
import '../search_data_source/search_remote_data_source.dart';
import '../search_model/SearchModel.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchDataSource searchDataSource;

  SearchRepoImpl(this.searchDataSource);

  @override
  Future<Either<Failure, List<SearchProduct>>> search({
    required String text,
  }) async {
    return await searchDataSource.search(text: text);
  }
}
