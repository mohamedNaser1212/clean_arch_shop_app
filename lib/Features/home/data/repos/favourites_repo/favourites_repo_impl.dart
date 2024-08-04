import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/models/GetFavouritsModel.dart';

import '../../data_sorces/get_favourites_data_source.dart';
import 'favourites_repo.dart';

class FavouritesRepoImpl extends FavouritesRepo {
  final GetFavouritesDataSource getFavouritesDataSource;

  FavouritesRepoImpl({required this.getFavouritesDataSource});

  @override
  Future<Either<Failure, List<Product>>> GetFavourites() async {
    try {
      final favourites = await getFavouritesDataSource.getFavourites();
      return favourites;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // @override
  // Future<Either GetFavourites() async{
  //
  //   var favourites = await getFavouritesDataSource.getFavourites();
  //   if (favourites.isEmpty) {
  //     throw ServerFailure('No Favourites');
  //   }else if(favourites.isNotEmpty){
  //     return favourites;
  //   }
  //
  //
  //   return favourites;
  //
  //
  //
  //
  // }
}
