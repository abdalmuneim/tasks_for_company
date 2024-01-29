import 'package:flutter/cupertino.dart';
import 'package:pexlesart/models/favorit_model.dart';

import '../db/db_helper.dart';

class FavoriteViewModel extends ChangeNotifier {
  List<FavoriteModel> favoriteList = <FavoriteModel>[];

  Future<int> addToFavorite({required FavoriteModel favorite}) {
    notifyListeners();
    return DBHelper.insert(favorite);
  }

  Future<List<FavoriteModel>> getFavorite() async {
    favoriteList = await DBHelper.query();
    notifyListeners();
    return favoriteList;
  }

  void deleteFavorite(int id) async {
    await DBHelper.deleted(id);
    isFav(id);
    getFavorite();
    notifyListeners();
  }

  void deleteAllFavorite() async {
    await DBHelper.deletedAll();
    getFavorite();
    notifyListeners();
  }

 late bool fav ;

  bool isFav(int id) {
    return fav = favoriteList.any((e) => e.id == id);
  }
}
