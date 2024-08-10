// import 'package:hive/hive.dart';
// import 'package:shop_app/Features/home/domain/entities/favourites_entity/favourites_entity.dart';
//
// Future<void> saveFavourites(
//     List<FavouritesEntity> favourites, String boxName) async {
//   var box = await Hive.openBox<FavouritesEntity>(boxName);
//   await box.clear();
//   await box.addAll(favourites);
// }
//
// Future<List<FavouritesEntity>> loadFavourites(String boxName) async {
//   var box = await Hive.openBox<FavouritesEntity>(boxName);
//   return box.values.toList();
// }
