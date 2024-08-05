import 'package:dartz/dartz.dart';
import 'package:shop_app/core/widgets/api_service.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../models/SearchModel.dart';

abstract class SearchDataSource {
  Future<Either<Failure, List<SearchProduct>>> search(String text);
}

class SearchDataSourceImpl implements SearchDataSource {
  final ApiService apiService;

  SearchDataSourceImpl(this.apiService);

  @override
  Future<Either<Failure, List<SearchProduct>>> search(String text) async {
    try {
      final response =
          await apiService.post(endPoint: searchEndPoint, data: {'text': text});
      final searchModel = SearchModel.fromJson(
          response); // Ensure `SearchModel.fromJson` is used
      return Right(searchModel.data?.data ?? []);
    } catch (e) {
      print('Error searching: $e');
      return Left(ServerFailure('Error searching: $e'));
    }
  }
}
