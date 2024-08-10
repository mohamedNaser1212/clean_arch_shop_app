import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/favourites_entity/favourites_entity.dart';

import '../../../../../core/errors/failure.dart';

abstract class FavouritesRepo {
  Future<Either<Failure, List<FavouritesEntity>>> getFavourites();
  Future<Either<Failure, bool>> toggleFavourite(num productIds);
}
