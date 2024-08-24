import '../../../../core/networks/api_manager/api_helper.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/dio_data_name.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../search_model/search_data.dart';

abstract class SearchDataSource {
  const SearchDataSource();

  Future<List<SearchProduct>> search({
    required String text,
  });
}

class SearchDataSourceImpl implements SearchDataSource {
  final ApiHelper apiService;

  const SearchDataSourceImpl({
    required this.apiService,
  });

  @override
  Future<List<SearchProduct>> search({
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

    List<SearchProduct> products = [];
    if (response['data'] != null) {
      for (var item in response['data']['data']) {
        products.add(SearchProduct.fromJson(item));
      }
    }
    return products;
  }
}
