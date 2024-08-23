import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/api_service_interface.dart';
import '../../../../core/networks/api_manager/dio_data_name.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../search_model/SearchModel.dart';
import '../search_model/search_data.dart';

abstract class SearchDataSource {
  Future<Either<Failure, List<SearchProduct>>> search({
    required String text,
  });
}

class SearchDataSourceImpl implements SearchDataSource {
  final ApiHelper apiService;

  const SearchDataSourceImpl({
    required this.apiService,
  });

  @override
  Future<Either<Failure, List<SearchProduct>>> search({
    required String text,
  }) async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.searchEndPoint,
        data: {
          RequestDataNames.text: text,
        },
        headerModel: HeaderModel(),
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
