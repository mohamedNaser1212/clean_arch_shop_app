import 'package:shop_app/core/models/api_request_model/api_request_model.dart';
import 'package:shop_app/core/widgets/api_service.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../core/widgets/constants.dart';
import '../favourites_models/favoutits_model.dart';
import '../favourites_models/new_favourites_model.dart';

abstract class GetFavouritesDataSource {
  Future<List<FavouriteProduct>> getFavourites();
  Future<bool> toggleFavourites(num productIds);
}

class GetFavouritesDataSourceImpl implements GetFavouritesDataSource {
  final ApiService apiService;
  ChangeFavouriteModel? changeFavouriteModel;

  GetFavouritesDataSourceImpl({required this.apiService});

  @override
  Future<List<FavouriteProduct>> getFavourites() async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: favoritesEndPoint,
        headers: {'Authorization': token},
      );
      final response = await apiService.get(
        request: request,
      );

      List<FavouriteProduct> favouriteProducts = [];
      if (response['data']['data'] != null) {
        for (var item in response['data']['data']) {
          favouriteProducts.add(FavouriteProduct.fromJson(item['product']));
        }
      }

      // await saveFavourites(_cachedFavourites, kFavouritesBox);

      return favouriteProducts;
    } catch (e) {
      print('Error fetching favourites: $e');
      rethrow;
    }
  }

  @override
  Future<bool> toggleFavourites(num productIds) async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: favoritesEndPoint,
        headers: {'Authorization': token},
        data: {
          'product_id': productIds,
        },
      );

      final response = await apiService.post(
        request: request,
      );
      changeFavouriteModel = ChangeFavouriteModel.fromJson(response);

      return changeFavouriteModel?.status ?? false;
    } catch (e) {
      print('Error toggling favourites: $e');
      rethrow;
    }
  }
}
