import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/errors_manager/internet_failure.dart';
import '../../../../core/initial_screen/manager/internet_manager/internet_manager.dart';
import '../../domain/search_repo/search_repo.dart';
import '../search_data_source/search_remote_data_source.dart';
import '../search_model/search_response_model.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchRemoteDataSource searchDataSource;
  final InternetManager internetManager;
  const SearchRepoImpl({
    required this.searchDataSource,
    required this.internetManager,
  });

  @override
  Future<Either<Failure, List<SearchResponseModel>>> search({
    required String text,
  }) async {
    try {
      final isConnected = await internetManager.checkConnection();
      if (!isConnected) {
        return left(
          InternetFailure.fromConnectionStatus(
            InternetConnectionStatus.disconnected,
          ),
        );
      }
      final searchResult = await searchDataSource.search(text: text);
      return right(searchResult);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
