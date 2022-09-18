import 'dart:io';


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/booking_model.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();

  static Database? _database;

  static const int _version = 1;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('booking.db');
    return _database!;
  }

  Future<Database> _initDB(String pathFile) async {
    String dbPath = await getDatabasesPath();
    final String path = join(dbPath, pathFile);
    return await openDatabase(path, version: _version, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    const idBooking = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const guestName = "TEXT NOT NULL";
    const guestNum = "TEXT NOT NULL";
    const hotelBranch = "TEXT NOT NULL";
    const roomNum = "TEXT NOT NULL";
    const suit = "TEXT NOT NULL";
    const startTime = "TEXT NOT NULL";
    const daysNum = "TEXT NOT NULL";
    const totalPrice = "DOUBLE NOT NULL";

    await db.execute('''
    CREATE TABLE $tableBooking(
    ${BookingFields.id} $idBooking,
    ${BookingFields.guestName} $guestName,
    ${BookingFields.guestNum} $guestNum,
    ${BookingFields.hotelBranch} $hotelBranch,
    ${BookingFields.roomNum} $roomNum,
    ${BookingFields.suit} $suit,
    ${BookingFields.startTime} $startTime,
    ${BookingFields.daysNum} $daysNum,
    ${BookingFields.totalPrice} $totalPrice)
    ''');
  }

  Future<BookingModel> createBooking(BookingModel bookingModel) async {
    final db = await instance.database;
    final id = await db.insert(tableBooking, bookingModel.toJson());
    return bookingModel.copy(id: id);
  }

  Future<BookingModel> readBooking(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableBooking,
      columns: BookingFields.values,
      where: '${BookingFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return BookingModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not fond');
    }
  }

  Future<List<BookingModel>> readAllBooking() async {
    final db = await instance.database;
    final result = await db.query(tableBooking);
    return result.map((json) => BookingModel.fromJson(json)).toList();
  }

  Future<int> update(BookingModel bookingModel) async {
    final db = await instance.database;
    return db.update(
      tableBooking,
      bookingModel.toJson(),
      where: '${BookingFields.id} = ?',
      whereArgs: [bookingModel.id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
