import 'package:hive/hive.dart';

import '../../domain/favourites_entity/favourites_entity.dart';

Future<void> saveFavourites(
    List<FavouritesEntity> favourites, String boxName) async {
  var box = await Hive.openBox<FavouritesEntity>(boxName);
  await box.clear();
  await box.addAll(favourites);
}

Future<List<FavouritesEntity>> loadFavourites(String boxName) async {
  var box = await Hive.openBox<FavouritesEntity>(boxName);
  return box.values.toList();
}
