import '../../../../core/networks/api_manager/api_helper.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/dio_data_name.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../favourites_models/favourites_response_model.dart';

abstract class FavouritesRemoteDataSource {
  const FavouritesRemoteDataSource();
  Future<List<FavouritesResponseModel>> getFavourites();
  Future<bool> toggleFavourites(num productId);
}

class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  final ApiHelper apiHelper;

  const FavouritesRemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<List<FavouritesResponseModel>> getFavourites() async {
    final request = ApiRequestModel(
      endpoint: EndPoints.favoritesEndPoint,
      headerModel: HeaderModel(),
    );
    final response = await apiHelper.get(request: request);

    var favouriteProducts = getFavouritesItems(response);

    print('Favourite items fetched successfully');
    return favouriteProducts;
  }

  @override
  Future<bool> toggleFavourites(num productId) async {
    try {
      final request = ApiRequestModel(
        endpoint: EndPoints.favoritesEndPoint,
        data: {
          RequestDataNames.productId: productId,
        },
        headerModel: HeaderModel(),
      );
      final response = await apiHelper.post(request: request);

      return response['status'] == true ? true : false;
    } catch (error) {
      print('Failed to toggle favourite item: $error');
      return false;
    }
  }

  getFavouritesItems(Map<String, dynamic> response) {
    final data = response['data']['data'] ?? [];
    final favouriteProducts = data.map<FavouritesResponseModel>((item) {
      return FavouritesResponseModel.fromJson(item['product']);
    }).toList();
    return favouriteProducts;
  }
}
