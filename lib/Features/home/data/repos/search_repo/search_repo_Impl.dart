import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/data/repos/search_repo/search_repo.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../../../models/SearchModel.dart';
import '../../data_sorces/remote_data_sources/search_data_source.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchDataSource searchDataSource;

  SearchRepoImpl(this.searchDataSource);

  @override
  Future<Either<Failure, List<SearchProduct>>> search(String text) async {
    return await searchDataSource.search(text);
  }
}
