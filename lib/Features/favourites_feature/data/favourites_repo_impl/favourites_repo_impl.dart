import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/models/hive_manager/hive_manager.dart';

import '../../../../core/utils/screens/widgets/end_points.dart';
import '../../domain/favourites_entity/favourites_entity.dart';
import '../../domain/favourites_repo/favourites_repo.dart';
import '../favourite_data_source/favourite_remote_data_source.dart';

class FavouritesRepoImpl extends FavouritesRepo {
  final FavouritesRemoteDataSource getFavouritesDataSource;

  FavouritesRepoImpl({required this.getFavouritesDataSource});

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    try {
      final favourites = await getFavouritesDataSource.getFavourites();
      HiveManager.saveData<FavouritesEntity>(favourites, kFavouritesBox);
      favorites = {for (var p in favourites) p.id!: true};

      return right(favourites);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavourite(num productIds) async {
    try {
      final result = await getFavouritesDataSource.toggleFavourites(productIds);
      await getFavourites();
      return right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
