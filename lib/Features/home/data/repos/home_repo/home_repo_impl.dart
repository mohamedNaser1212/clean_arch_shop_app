import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/data/data_sorces/home_remote_data_source.dart';
import 'package:shop_app/Features/home/data/repos/home_repo/home_repo.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl(this.homeRemoteDataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProducts() async {
    try {
      final products = await homeRemoteDataSource.fetchProducts();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DataModel>>> fetchCategories() async {
    try {
      final categories = await homeRemoteDataSource.fetchCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, List<CategoriesModel>>> fetchCategories() {
  //   print('fetchCategories');
  //   return 'fetchCategories';
  // }

  // @override
  // Future<Either<Failure, List<CategoriesModel>>> fetchCategories() async {
  //   try {
  //     final categories = await homeRemoteDataSource.fetchCategories();
  //     return Right(categories);
  //   } catch (e) {
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }
}
