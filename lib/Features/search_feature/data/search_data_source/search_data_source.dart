import 'package:dartz/dartz.dart';
import 'package:shop_app/core/models/api_request_model/api_request_model.dart';
import 'package:shop_app/core/widgets/api_service.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../../core/errors/failure.dart';
import '../search_model/SearchModel.dart';

abstract class SearchDataSource {
  Future<Either<Failure, List<SearchProduct>>> search(String text);
}

class SearchDataSourceImpl implements SearchDataSource {
  final ApiService apiService;

  SearchDataSourceImpl(this.apiService);

  @override
  Future<Either<Failure, List<SearchProduct>>> search(String text) async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: searchEndPoint,
        data: {'text': text},
      );
      final response = await apiService.post(request: request);
      final searchModel = SearchModel.fromJson(response);
      return Right(searchModel.data?.data ?? []);
    } catch (e) {
      print('Error searching: $e');
      return Left(ServerFailure('Error searching: $e'));
    }
  }
}
