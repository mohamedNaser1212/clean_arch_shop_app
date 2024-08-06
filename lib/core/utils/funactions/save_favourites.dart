import 'package:hive/hive.dart';

import '../../../Features/home/domain/entities/favourites_entity/favourites_entity.dart';

void saveFavourites(List<FavouritesEntity> favourites, String boxName) {
  var box = Hive.box<FavouritesEntity>(boxName);
  box.addAll(favourites);
}
