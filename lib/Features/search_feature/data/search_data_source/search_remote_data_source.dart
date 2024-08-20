import 'package:dartz/dartz.dart';
import 'package:shop_app/core/models/api_request_model/api_request_model.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../core/utils/api_services/api_service_interface.dart';
import '../../../../core/utils/end_points/end_points.dart';
import '../search_model/SearchModel.dart';

abstract class SearchDataSource {
  Future<Either<Failure, List<SearchProduct>>> search({
    required String text,
  });
}

class SearchDataSourceImpl implements SearchDataSource {
  final ApiServiceInterface apiService;

  SearchDataSourceImpl(this.apiService);

  @override
  Future<Either<Failure, List<SearchProduct>>> search({
    required String text,
  }) async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.searchEndPoint,
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
