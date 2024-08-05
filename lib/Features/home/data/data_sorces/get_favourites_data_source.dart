import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/widgets/constants.dart';
import '../../../../core/widgets/dio_helper.dart';
import '../../../../core/widgets/end_points.dart';
import '../../../../models/GetFavouritsModel.dart';

abstract class GetFavouritesDataSource {
  Future<Either<Failure, List<Product>>> getFavourites();

  Future<Either<Failure, bool>> toggleFavourite(num productId);
}

class GetFavouritesDataSourceImpl implements GetFavouritesDataSource {
  final ApiService apiService;
  List<Product> _cachedFavourites = [];

  GetFavouritesDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, List<Product>>> getFavourites() async {
    try {
      final response = await apiService.get(
        endPoint: favoritesEndPoint,
        headers: {'Authorization': token},
      );

      final favouritesModel = GetFavouritsModel.fromJson(response);
      _cachedFavourites =
          favouritesModel.data!.data!.map((item) => item.product!).toList();

      return Right(_cachedFavourites);
    } catch (e) {
      print('Error fetching favourites: $e');
      return Left(ServerFailure('Error fetching favourites: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavourite(num productId) async {
    try {
      final response = await apiService.post(
        endPoint: favoritesEndPoint,
        headers: {'Authorization': token},
        data: {'product_id': productId},
      );

      final isFavourite = response['status'];
      if (isFavourite) {
        _cachedFavourites.add(
          Product.fromJson({
            'id': productId,
            // Assuming you have other fields to add
          }),
        );
      } else {
        _cachedFavourites.removeWhere((product) => product.id == productId);
      }

      return Right(isFavourite);
    } catch (e) {
      print('Error toggling favourite: $e');
      return Left(ServerFailure('Error toggling favourite: $e'));
    }
  }
}
