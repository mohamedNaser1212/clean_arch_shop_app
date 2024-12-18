import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/home_repo/home_repo.dart';

import '../../../../../core/managers/errors_manager/failure.dart';
import '../../entities/categories_entity/categories_entity.dart';

class CategoriesUseCase {
  final HomeRepo homeRepo;

  const CategoriesUseCase({
    required this.homeRepo,
  });

  Future<Either<Failure, List<CategoriesEntity>>> call() {
    return homeRepo.fetchCategories();
  }
}
