import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/house.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  static String path;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      print("xxxxxxxxxxx making new DB xxxxxxxxxxxxx");
      await db.execute("CREATE TABLE recently_viewed ("
          "id INTEGER PRIMARY KEY,"
          "street_address TEXT,"
          "city TEXT,"
          "state TEXT,"
          "zip_code TEXT,"
          "photo_url TEXT,"
          "beds TEXT,"
          "baths TEXT"
          ")");
    });
  }

  // RECENTLY VIEWED HOUSES /////////////////////////////////////////////////////
  newHouse(House newHouse) async {
    final db = await database;
    var res = await db.insert("recently_viewed", newHouse.toMap());
    return res;
  }

  getHouse(int id) async {
    final db = await database;
    var res =await  db.query("recently_viewed", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? House.fromMap(res.first) : Null ;
  }

  getAllHouses() async {
    final db = await database;
    var res = await db.query("recently_viewed");
    List<House> list =
    res.isNotEmpty ? res.map((c) => House.fromMap(c)).toList() : [];
    return list;
  }

  updateHouse(House newHouse) async {
    final db = await database;
    var res = await db.update("recently_viewed", newHouse.toMap(),
        where: "id = ?", whereArgs: [newHouse.id]);
    return res;
  }

  deleteHouse(int id) async {
    final db = await database;
    db.delete("recently_viewed", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    deleteDatabase(path);
  }
}



