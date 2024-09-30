import '../../../../core/networks/api_manager/api_manager.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/request_data_names.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../search_model/search_model.dart';

abstract class SearchRemoteDataSource {
  const SearchRemoteDataSource._();

  Future<List<SearchModel>> search({
    required String text,
  });
}

class SearchDataSourceImpl implements SearchRemoteDataSource {
  final ApiHelper apiHelper;

  const SearchDataSourceImpl({
    required this.apiHelper,
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

    final response = await apiHelper.post(request: request);

    List<SearchModel> products = [];
    searchList(response, products);
    return products;
  }
}

void searchList(Map<String, dynamic> response, List<SearchModel> products) {
  if (response[RequestDataNames.data] != null) {
    for (var item in response[ RequestDataNames.data][ RequestDataNames.data]) {
      products.add(SearchModel.fromJson(item));
    }
  }
}
