import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/favourites_feature/data/favourites_local_data_source/save_favourites.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../domain/favourites_entity/favourites_entity.dart';
import '../../domain/favourites_repo/favourites_repo.dart';
import '../favourite_data_source/get_favourite_data_source.dart';

class FavouritesRepoImpl extends FavouritesRepo {
  final GetFavouritesDataSource getFavouritesDataSource;

  FavouritesRepoImpl({required this.getFavouritesDataSource});

  @override
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites() async {
    try {
      final favourites = await getFavouritesDataSource.getFavourites();
      saveFavourites(favourites, kFavouritesBox);
      return right(favourites);
    } catch (e) {
      return Right(await loadFavourites(kFavouritesBox));
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
