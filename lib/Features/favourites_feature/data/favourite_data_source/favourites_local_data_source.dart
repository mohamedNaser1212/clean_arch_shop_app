import '../../../../core/networks/Hive_manager/hive_boxes_names.dart';
import '../../../../core/networks/Hive_manager/hive_helper.dart';
import '../../domain/favourites_entity/favourites_entity.dart';

abstract class FavouritesLocalDataSource {
  Future<List<FavouritesEntity>> getFavourites();
  Future<void> saveFavourites(List<FavouritesEntity> favourites);
  Future<void> removeFavourite(num productId);
}

class FavouritesLocalDataSourceImpl implements FavouritesLocalDataSource {
  final HiveHelper hiveService;

  FavouritesLocalDataSourceImpl({
    required this.hiveService,
  });

  @override
  Future<List<FavouritesEntity>> getFavourites() async {
    final favourites = await hiveService
        .loadData<FavouritesEntity>(HiveBoxesNames.kFavouritesBox);
    return favourites;
  }

  @override
  Future<void> saveFavourites(List<FavouritesEntity> favourites) async {
    await hiveService.saveData<FavouritesEntity>(
        favourites, HiveBoxesNames.kFavouritesBox);
  }

  @override
  Future<void> removeFavourite(num productId) async {
    final favouritesResult = await getFavourites();

    final updatedFavourites =
        favouritesResult.where((item) => item.id != productId).toList();

    await saveFavourites(updatedFavourites);
  }
}
