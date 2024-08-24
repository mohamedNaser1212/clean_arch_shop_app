import '../../../../core/networks/api_manager/api_helper.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/dio_data_name.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../search_model/search_model.dart';

abstract class SearchRemoteDataSource {
  const SearchRemoteDataSource();

  Future<List<SearchModel>> search({
    required String text,
  });
}

class SearchDataSourceImpl implements SearchRemoteDataSource {
  final ApiHelper apiService;

  const SearchDataSourceImpl({
    required this.apiService,
  });

  @override
  Future<List<SearchModel>> search({
    required String text,
  }) async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.searchEndPoint,
      data: {
        RequestDataNames.text: text,
      },
      headerModel: HeaderModel(),
    );

    final response = await apiService.post(request: request);

    List<SearchModel> products = [];
    if (response['data'] != null) {
      for (var item in response['data']['data']) {
        products.add(SearchModel.fromJson(item));
      }
    }
    return products;
  }
}
