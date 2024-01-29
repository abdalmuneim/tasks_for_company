import 'package:pexlesart/models/favorit_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/material.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'Favorite';

  static Future<void> initDB() async {
    if (_db != null) {
      debugPrint('not null data base');
      return;
    } else {
      try {
        String _path = '${await getDatabasesPath()}favorite.db';
        _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          debugPrint('create new data base');
          await db.execute(
            'CREATE TABLE $_tableName ('
            'id INTEGER,'
            'width INTEGER,'
            'height INTEGER,'
            'photographerId INTEGER,'
            'photographer STRING,'
            'photographerUrl STRING,'
            'avgColor STRING,'
            'original STRING,'
            'alt STRING)',
          );
        });
      } catch (e) {
        debugPrint('$e');
      }
    }
  }

  static Future<int> insert(FavoriteModel favorite) async {
    debugPrint('Insert method.');
    return await _db!.insert(_tableName, favorite.toJson());
  }

  static Future<int> deleted(int id) async {
    debugPrint('deleted method.');
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deletedAll() async {
    debugPrint('deleted method.');
    return await _db!.delete(_tableName);
  }

  static Future<List<FavoriteModel>> query() async {
    debugPrint('query method.');
    final List<Map<String, Object?>> queryResult = await _db!.query(_tableName);
    return queryResult.map((e) => FavoriteModel.fromJson(e)).toList();
  }
}
