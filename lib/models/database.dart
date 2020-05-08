import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'house_model.dart';

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
      await db.execute("CREATE TABLE Houses ("
          "id INTEGER PRIMARY KEY,"
          "street_address TEXT,"
          "city TEXT,"
          "state TEXT,"
          "zip_code TEXT"
          ")");
    });
  }

  newClient(House newHouse) async {
    final db = await database;
    var res = await db.insert("Houses", newHouse.toMap());
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res =await  db.query("Houses", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? House.fromMap(res.first) : Null ;
  }

  getAllClients() async {
    final db = await database;
    var res = await db.query("Houses");
    List<House> list =
    res.isNotEmpty ? res.map((c) => House.fromMap(c)).toList() : [];
    return list;
  }

//  getBlockedClients() async {
//    final db = await database;
//    var res = await db.rawQuery("SELECT * FROM Houses WHERE blocked=1");
//    List<House> list =
//    res.isNotEmpty ? res.toList().map((c) => House.fromMap(c)) : null;
//    return list;
//  }

  updateClient(House newHouse) async {
    final db = await database;
    var res = await db.update("Houses", newHouse.toMap(),
        where: "id = ?", whereArgs: [newHouse.id]);
    return res;
  }

  deleteClient(int id) async {
    final db = await database;
    db.delete("Houses", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    deleteDatabase(path);
  }
}

