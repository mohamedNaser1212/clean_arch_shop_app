import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../models/GetFavouritsModel.dart';
import '../../../data/repos/favourites_repo/favourites_repo.dart';

class FetchFavouritesUseCase extends FavouritesUseCase<Product> {
  final FavouritesRepo favouritesRepo;

  FetchFavouritesUseCase(this.favouritesRepo);

  @override
  Future<Either<Failure, List<Product>>> call() async {
    return await favouritesRepo.GetFavourites();
  }
}

class ToggleFavouriteUseCase {
  final FavouritesRepo favouritesRepo;

  ToggleFavouriteUseCase(this.favouritesRepo);

  Future<Either<Failure, bool>> call(num productId) async {
    return await favouritesRepo.toggleFavourite(productId);
  }
}

abstract class FavouritesUseCase<T> {
  Future<Either<Failure, List<T>>> call();
}
