import '../../../../core/networks/hive_manager/hive_boxes_names.dart';
import '../../../../core/networks/hive_manager/hive_helper.dart';
import '../../domain/favourites_entity/favourites_entity.dart';

abstract class FavouritesLocalDataSource {
  const FavouritesLocalDataSource._();
  Future<List<FavouritesEntity>> getFavourites();
  Future<void> saveFavourites({
    required List<FavouritesEntity> favourites,
  });
  Future<void> removeFavourite({
    required num productId,
  });
  Future<void> clearFavourites();
}

class FavouritesLocalDataSourceImpl implements FavouritesLocalDataSource {
  final LocalStorageManager hiveHelper;

  const FavouritesLocalDataSourceImpl({
    required this.hiveHelper,
  });

  @override
  Future<List<FavouritesEntity>> getFavourites() async {
    final favourites = await hiveHelper
        .loadData<FavouritesEntity>(HiveBoxesNames.kFavouritesBox);
    return favourites;
  }

  @override
  Future<void> saveFavourites({
    required List<FavouritesEntity> favourites,
  }) async {
    await hiveHelper.saveData<FavouritesEntity>(
        favourites, HiveBoxesNames.kFavouritesBox);
  }

  @override
  Future<void> removeFavourite({
    required num productId,
  }) async {
    final favouritesResult = await getFavourites();

    final updatedFavourites =
        favouritesResult.where((item) => item.id != productId).toList();

    await saveFavourites(favourites: updatedFavourites);
  }

  @override
  Future<void> clearFavourites() async {
    await hiveHelper.clearData<FavouritesEntity>(HiveBoxesNames.kFavouritesBox);
  }
}
