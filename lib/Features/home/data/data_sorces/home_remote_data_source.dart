import 'package:shop_app/core/widgets/end_points.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

import '../../../../core/widgets/dio_helper.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
  Future<List<DataModel>> fetchCategories();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;
  List<ProductModel>? _cachedProducts;
  List<DataModel>? _cachedCategories;

  HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<ProductModel>> fetchProducts() async {
    // Check if data is already cached
    if (_cachedProducts != null) {
      return _cachedProducts!;
    }

    try {
      final response = await apiService.get(endPoint: homeEndPoint);
      final data = response['data'] as Map<String, dynamic>?;
      final productsData = data?['products'] as List<dynamic>?;

      if (productsData == null || productsData.isEmpty) {
        return [];
      }

      _cachedProducts = productsData
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return _cachedProducts!;
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Error fetching products');
    }
  }

  @override
  Future<List<DataModel>> fetchCategories() async {
    // Check if data is already cached
    if (_cachedCategories != null) {
      return _cachedCategories!;
    }

    try {
      final response = await apiService.get(endPoint: categoriesEndPoint);
      final data = response['data'] as Map<String, dynamic>?;
      final categoriesData = data?['data'] as List<dynamic>?;

      if (categoriesData == null || categoriesData.isEmpty) {
        return [];
      }

      _cachedCategories = categoriesData
          .map((e) => DataModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return _cachedCategories!;
    } catch (e) {
      print('Error fetching categories: $e');
      throw Exception('Error fetching categories');
    }
  }
}
//import 'package:shop_app/core/widgets/end_points.dart';
// import 'package:shop_app/models/categories_model.dart';
// import 'package:shop_app/models/home_model.dart';
//
// import '../../../../core/widgets/dio_helper.dart';
//
// abstract class HomeRemoteDataSource {
//   Future<List<ProductModel>> fetchProducts();
//   Future<List<DataModel>> fetchCategories();
// }
//
// class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
//   final ApiService apiService;
//   List<ProductModel>? _cachedProducts;
//   List<DataModel>? _cachedCategories;
//
//   HomeRemoteDataSourceImpl(this.apiService);
//
//   @override
//   Future<List<ProductModel>> fetchProducts() async {
//     // Check if data is already cached
//     if (_cachedProducts != null) {
//       return _cachedProducts!;
//     }
//     try {
//       final response = await apiService.get(endPoint: homeEndPoint);
//       print('Products response: $response');
//       final data = response['data'] as Map<String, dynamic>?;
//       final productsData = data?['products'] as List<dynamic>?;
//
//       if (productsData == null || productsData.isEmpty) {
//         return [];
//       }
//
//       _cachedProducts = productsData
//           .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
//           .toList();
//
//       return _cachedProducts!;
//     } catch (e) {
//       print('Error fetching products: $e');
//       return [];
//     }
//   }
//
//   @override
//   Future<List<DataModel>> fetchCategories() async {
//     // Check if data is already cached
//     if (_cachedCategories != null) {
//       return _cachedCategories!;
//     }
//     try {
//       final response = await apiService.get(endPoint: categoriesEndPoint);
//       final data = response['data'] as Map<String, dynamic>?;
//       print('Categories response: $response');
//       final categoriesData = data?['data'] as List<dynamic>?;
//
//       if (categoriesData == null || categoriesData.isEmpty) {
//         return [];
//       }
//
//       _cachedCategories = categoriesData
//           .map((e) => DataModel.fromJson(e as Map<String, dynamic>))
//           .toList();
//
//       return _cachedCategories!;
//     } catch (e) {
//       print('Error fetching categories: $e');
//       return [];
//     }
//   }
// }
