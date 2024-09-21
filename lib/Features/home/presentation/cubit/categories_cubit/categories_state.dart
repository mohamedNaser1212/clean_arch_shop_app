part of 'categories_cubit.dart';

class CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoriesEntity> categories;

  CategoriesSuccess(this.categories);
}

class CategoriesError extends CategoriesState {
  final String error;

  CategoriesError({
    required this.error,
  });
}

class ClearCategories extends CategoriesState {}
