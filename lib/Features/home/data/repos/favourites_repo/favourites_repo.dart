import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../models/GetFavouritsModel.dart';

abstract class FavouritesRepo {
  Future<Either<Failure, List<Product>>> GetFavourites();
  Future<Either<Failure, bool>> toggleFavourite(num productId);
}
