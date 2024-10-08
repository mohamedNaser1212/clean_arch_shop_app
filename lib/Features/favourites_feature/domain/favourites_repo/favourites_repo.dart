import 'package:dartz/dartz.dart';

import '../../../../core/managers/errors_manager/failure.dart';
import '../favourites_entity/favourites_entity.dart';

abstract class FavouritesRepo {
  const FavouritesRepo();
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites();
  Future<Either<Failure, bool>> toggleFavourite({
    required num productId,
  });
}
