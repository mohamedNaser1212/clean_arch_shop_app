import '../../../../core/networks/api_manager/api_manager.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/request_data_names.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../favourites_models/favourites_response_model.dart';

abstract class FavouritesRemoteDataSource {
  const FavouritesRemoteDataSource._();
  Future<List<FavouritesResponseModel>> getFavourites();
  Future<bool> toggleFavourites({
    required num productId,
  });
}

class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  final ApiHelper apiHelper;

  const FavouritesRemoteDataSourceImpl({
    required this.apiHelper,
  });

  @override
  Future<List<FavouritesResponseModel>> getFavourites() async {
    final request = ApiRequestModel(
      endpoint: EndPoints.favoritesEndPoint,
      headerModel: HeaderModel(),
    );
    final response = await apiHelper.get(request: request);
    var favouriteProducts = getFavouritesItems(response);
    return favouriteProducts;
  }

  @override
  Future<bool> toggleFavourites({
    required num productId,
  }) async {
    final request = ApiRequestModel(
      endpoint: EndPoints.favoritesEndPoint,
      data: {
        RequestDataNames.productId: productId,
      },
      headerModel: HeaderModel(),
    );
    final response = await apiHelper.post(request: request);

    return response[RequestDataNames.status] == true ? true : false;
  }

  List<FavouritesResponseModel> getFavouritesItems(
      Map<String, dynamic> response) {
    final data = response[RequestDataNames.data][RequestDataNames.data] ?? [];
    final favouriteProducts = data.map<FavouritesResponseModel>((item) {
      return FavouritesResponseModel.fromJson(item[RequestDataNames.product]);
    }).toList();
    return favouriteProducts;
  }
}
