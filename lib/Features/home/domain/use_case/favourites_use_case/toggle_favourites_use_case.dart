import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/repos/favourites_repo/favourites_repo.dart';

class ToggleFavouriteUseCase {
  final FavouritesRepo favouritesRepo;

  ToggleFavouriteUseCase(this.favouritesRepo);

  Future<Either<Failure, bool>> call(num productIds) async {
    return await favouritesRepo.toggleFavourite(productIds);
  }
}
