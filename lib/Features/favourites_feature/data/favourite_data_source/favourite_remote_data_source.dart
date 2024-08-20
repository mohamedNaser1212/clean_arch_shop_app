import 'package:shop_app/core/models/api_request_model/api_request_model.dart';

import '../../../../core/utils/api_services/api_service_interface.dart';
import '../../../../core/utils/end_points/end_points.dart';
import '../../../../core/utils/widgets/cache_helper.dart';
import '../favourites_models/favourites_model.dart';
import '../favourites_models/favoutits_model.dart';

abstract class FavouritesRemoteDataSource {
  Future<List<FavouriteProduct>> getFavourites();
  Future<bool> toggleFavourites(num productId);
}

class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  final ApiServiceInterface apiService;

  FavouritesRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<FavouriteProduct>> getFavourites() async {
    try {
      final token = HiveHelper.getToken();

      final request = ApiRequestModel(
        endpoint: EndPoints.favoritesEndPoint,
        headerModel: HeaderModel(authorization: token),
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
      final token = HiveHelper.getToken();

      final request = ApiRequestModel(
        endpoint: EndPoints.favoritesEndPoint,
        data: {'product_id': productId},
        headerModel: HeaderModel(authorization: token),
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
