import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/networks/Hive_manager/hive_boxes_names.dart';
import '../../../../core/networks/Hive_manager/hive_service.dart';
import '../../domain/favourites_entity/favourites_entity.dart';

abstract class FavouritesLocalDataSource {
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites();
  Future<Either<Failure, void>> saveFavourites(
      List<FavouritesEntity> favourites);
  Future<Either<Failure, void>> removeFavourite(num productId);
}

class FavouritesLocalDataSourceImpl implements FavouritesLocalDataSource {
  final HiveHelper hiveService;

  FavouritesLocalDataSourceImpl({
    required this.hiveService,
  });

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    try {
      final favourites = await hiveService
          .loadData<FavouritesEntity>(HiveBoxesNames.kFavouritesBox);
      return right(favourites);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveFavourites(
      List<FavouritesEntity> favourites) async {
    try {
      await hiveService.saveData<FavouritesEntity>(
          favourites, HiveBoxesNames.kFavouritesBox);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavourite(num productId) async {
    try {
      final favouritesResult = await getFavourites();
      if (favouritesResult.isRight()) {
        final updatedFavourites = favouritesResult
            .getOrElse(() => [])
            .where((item) => item.id != productId)
            .toList();
        await saveFavourites(updatedFavourites);
      }
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
