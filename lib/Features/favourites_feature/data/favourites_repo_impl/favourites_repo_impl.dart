import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../../core/networks/Hive_manager/hive_boxes_names.dart';
import '../../../../core/networks/Hive_manager/hive_service.dart';
import '../../domain/favourites_entity/favourites_entity.dart';
import '../../domain/favourites_repo/favourites_repo.dart';
import '../favourite_data_source/favourite_remote_data_source.dart';

class FavouritesRepoImpl extends FavouritesRepo {
  final FavouritesRemoteDataSource getFavouritesDataSource;
  final HiveService hiveService;

  FavouritesRepoImpl({
    required this.getFavouritesDataSource,
    required this.hiveService,
  });

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    try {
      final favourites = await getFavouritesDataSource.getFavourites();
      await hiveService.saveData<FavouritesEntity>(
          favourites, HiveBoxesNames.kFavouritesBox);
      return right(favourites);
    } catch (e) {
      try {
        final cachedFavourites = await hiveService
            .loadData<FavouritesEntity>(HiveBoxesNames.kFavouritesBox);
        return right(cachedFavourites);
      } catch (_) {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavourite(
      {required num productId}) async {
    try {
      final result = await getFavouritesDataSource.toggleFavourites(productId);

      final updatedFavourites = await getFavourites();
      return right(result);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
