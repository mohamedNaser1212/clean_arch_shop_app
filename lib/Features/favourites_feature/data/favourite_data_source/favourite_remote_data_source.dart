import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/api_service_interface.dart';
import '../../../../core/networks/api_manager/dio_data_name.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../favourites_models/favourites_model.dart';
import '../favourites_models/favoutits_model.dart';

abstract class FavouritesRemoteDataSource {
  Future<List<FavouriteProduct>> getFavourites();
  Future<bool> toggleFavourites(num productId);
}

class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  final ApiManager apiService;

  const FavouritesRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<FavouriteProduct>> getFavourites() async {
    try {
      final request = ApiRequestModel(
        endpoint: EndPoints.favoritesEndPoint,
        headerModel: HeaderModel(),
      );
      final response = await apiService.get(request: request);

      final data = response['data']['data'] ?? [];
      final favouriteProducts = data.map<FavouriteProduct>((item) {
        return FavouriteProduct.fromJson(item['product']);
      }).toList();

      print('Favourite items fetched successfully');
      return favouriteProducts;
    } catch (error) {
      print('Failed to fetch favourite items: $error');
      return [];
    }
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
      final response = await apiService.post(request: request);

      final changeFavouriteModel = ChangeFavouriteModel.fromJson(response);
      return changeFavouriteModel.status ?? false;
    } catch (error) {
      print('Failed to toggle favourite item: $error');
      return false;
    }
  }
}
