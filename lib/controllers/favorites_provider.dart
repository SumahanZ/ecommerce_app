import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesNotifier extends ChangeNotifier {
  final _favBox = Hive.box("fav_box");
  List<dynamic> _ids = [];
  List<dynamic> _fav = [];

  List<dynamic> get ids => _ids;
  List<dynamic> get fav => _fav;

  set ids(List<dynamic> newIds) {
    _ids = newIds;
    notifyListeners();
  }

  set fav(List<dynamic> newFav) {
    _fav = newFav;
    notifyListeners();
  }
  

  //we still use hive for the favorites because we want the favorites to still be available even if we are offline
  void getFavorites() {
    final favData = _favBox.keys.map(
      (key) {
        final item = _favBox.get(key);
        return {
          "key": key,
          "id": item["id"],
          "name": item["name"],
          "category": item["category"],
          "price": item["price"],
          "imageUrl": item["imageUrl"]
        };
      },
    ).toList();

    //make ids here, to make managing the list of ids easy
    //if not we'd have to iterate over the keys of favbox in Hive again to get the favorites
    ids = favData.map((item) => item["id"]).toList();
    notifyListeners();
  }

  void getAllData() {
    final favData = _favBox.keys.map(
        (key) {
          final item = _favBox.get(key);
          return {
            "key": key,
            "id": item["id"],
            "name": item["name"],
            "category": item["category"],
            "price": item["price"],
            "imageUrl": item["imageUrl"]
          };
        },
      ).toList();

      _fav = favData.reversed.toList();
  }

  void deleteItemFromFavorite(int key) async {
    await _favBox.delete(key);
  }

  Future<void> createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
    getFavorites();
  }
}
