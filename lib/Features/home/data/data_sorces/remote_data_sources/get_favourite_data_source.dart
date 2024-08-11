import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/Features/home/domain/entities/favourites_entity/favourites_entity.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/widgets/api_service.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../../core/utils/funactions/save_favourites.dart';
import '../../../../../core/widgets/constants.dart';
import '../../../../../models/favoutits_model.dart';
import '../../../../../models/new_favourites_model.dart';

abstract class GetFavouritesDataSource {
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites();
  Future<Either<Failure, bool>> toggleFavourites(num productIds);
}

class GetFavouritesDataSourceImpl implements GetFavouritesDataSource {
  final ApiService apiService;
  List<FavouritesEntity> _cachedFavourites = [];
  ChangeFavouriteModel? changeFavouriteModel;

  GetFavouritesDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    try {
      final response = await apiService.get(
        endPoint: favoritesEndPoint,
        headers: {'Authorization': token},
      );

      final favouritesModel = NewFavouritesModel.fromJson(response);

      final Set<num> uniqueIds = {};
      _cachedFavourites = favouritesModel.data?.data
              ?.map((item) {
                if (item.product != null && uniqueIds.add(item.product!.id!)) {
                  return FavouritesEntity(
                    id: item.product!.id,
                    name: item.product!.name,
                    price: item.product!.price,
                    oldPrice: item.product!.oldPrice,
                    description:
                        item.product!.description ?? 'No description available',
                    discount: item.product!.discount,
                    image: item.product!.image,
                  );
                }
                return null; // If the item is a duplicate, return null
              })
              .where((item) => item != null) // Filter out the nulls
              .cast<FavouritesEntity>()
              .toList() ??
          [];

      await saveFavourites(_cachedFavourites, kFavouritesBox);

      return Right(_cachedFavourites);
    } catch (e) {
      print('Error fetching favourites: $e');
      return Right(await loadFavourites(kFavouritesBox));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavourites(num productIds) async {
    try {
      favorites?[productIds] = !(favorites?[productIds] ?? false);

      final response = await apiService.post(
        endPoint: favoritesEndPoint,
        data: {
          'product_id': productIds,
        },
        headers: {'Authorization': token},
      );
      changeFavouriteModel = ChangeFavouriteModel.fromJson(response);

      if (changeFavouriteModel!.status == false) {
        favorites?[productIds] = !(favorites?[productIds] ?? false);
      } else {
        // Only add the product if it's not already in the favorites list
        if (favorites?[productIds] == true &&
            !_cachedFavourites.any((fav) => fav.id == productIds)) {
          await getFavourites(); // Refresh favourites
        }
      }

      return Right(true);
    } catch (e) {
      print('Error toggling favourites: $e');
      favorites?[productIds] = !(favorites?[productIds] ?? false);
      return Left(ServerFailure('Error toggling favourites: $e'));
    }
  }

  Future<List<FavouritesEntity>> loadFavourites(String boxName) async {
    var box = await Hive.openBox<FavouritesEntity>(boxName);
    return box.values.toList();
  }
}
