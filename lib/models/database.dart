import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realtyapp/models/user.dart';
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
      print("xxxxxxxxxxx making new DB xxxxxxxxxxxxx");
      await db.execute("CREATE TABLE Houses ("
          "id INTEGER PRIMARY KEY,"
          "street_address TEXT,"
          "city TEXT,"
          "state TEXT,"
          "zip_code TEXT"
          ")");
      await db.execute("CREATE TABLE User ("
          "id INTEGER PRIMARY KEY,"
          "uid TEXT,"
          "first_name TEXT,"
          "last_name TEXT,"
          "phone_number TEXT,"
          "email TEXT,"
          "house INTEGER,"
          "agent INTEGER,"
          "profile_picture BLOB,"
          "FOREIGN KEY(house) REFERENCES Houses(id),"
          "FOREIGN KEY(agent) REFERENCES Agents(id)"
          ")");
      await db.execute("CREATE TABLE Agents ("
          "id INTEGER PRIMARY KEY,"
          "first_name TEXT,"
          "last_name TEXT,"
          "phone_number TEXT,"
          "email TEXT"
          ")");
    });
  }

  // USER(S) /////////////////////////////////////////////////////
  newUser(User newUser) async {
    final db = await database;
    var res = await db.insert("User", newUser.toMap());
    return res;
  }

  getAllUsers() async {
    final db = await database;
    var res = await db.query("User");
    List<User> list =
    res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  getUser(String uid) async {
    final db = await database;
    var res = await db.query("User", where: "uid = ?", whereArgs: [uid]);
    return res.isNotEmpty ? User.fromMap(res.first) : null ;
  }

  updateUser(User newUser) async {
    final db = await database;
    var res = await db.update("User", newUser.toMap(),
        where: "id = ?", whereArgs: [newUser.uid]);
    return res;
  }

  deleteUser(int id) async {
    final db = await database;
    db.delete("User", where: "id = ?", whereArgs: [id]);
  }


  // HOUSES /////////////////////////////////////////////////////
  newHouse(House newHouse) async {
    final db = await database;
    var res = await db.insert("Houses", newHouse.toMap());
    return res;
  }

  getHouse(int id) async {
    final db = await database;
    var res =await  db.query("Houses", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? House.fromMap(res.first) : Null ;
  }

  getAllHouses() async {
    final db = await database;
    var res = await db.query("Houses");
    List<House> list =
    res.isNotEmpty ? res.map((c) => House.fromMap(c)).toList() : [];
    return list;
  }

  updateHouse(House newHouse) async {
    final db = await database;
    var res = await db.update("Houses", newHouse.toMap(),
        where: "id = ?", whereArgs: [newHouse.id]);
    return res;
  }

  deleteHouse(int id) async {
    final db = await database;
    db.delete("Houses", where: "id = ?", whereArgs: [id]);
  }




  deleteAll() async {
    deleteDatabase(path);
  }
}



