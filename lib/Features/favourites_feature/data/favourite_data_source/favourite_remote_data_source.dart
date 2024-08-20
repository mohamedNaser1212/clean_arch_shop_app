import 'package:shop_app/core/models/api_request_model/api_request_model.dart';

import '../../../../core/utils/api_services/api_service_interface.dart';
import '../../../../core/utils/end_points/end_points.dart';
import '../../../../core/utils/widgets/constants.dart';
import '../favourites_models/favourites_model.dart';
import '../favourites_models/favoutits_model.dart';

abstract class FavouritesRemoteDataSource {
  Future<List<FavouriteProduct>> getFavourites();
  Future<bool> toggleFavourites(num productIds);
}

class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  final ApiServiceInterface apiService;
  ChangeFavouriteModel? changeFavouriteModel;

  FavouritesRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<FavouriteProduct>> getFavourites() async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.favoritesEndPoint,
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
  }

  @override
  Future<bool> toggleFavourites(num productIds) async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.favoritesEndPoint,
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
  }
}
