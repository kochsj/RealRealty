import 'dart:async';
import 'package:realtyapp/models/user.dart';

import 'models/house_model.dart';
import 'models/database.dart';


class ClientsBloc {
  ClientsBloc() {
    getHouses();
  }

  List<House> houses = [];
  User currentUser = User();

// USER(S) //////////////////////////////
  getUser(String uid) async {
    User _user = await DBProvider.db.getUser(uid);
    currentUser = _user;
//    return _user;
  }

  deleteUser(int id) {
    DBProvider.db.deleteUser(id);
  }

  addUser(User user) async {
    await DBProvider.db.newUser(user);
    currentUser = user;
  }

  updateUser(User user) {
    DBProvider.db.updateUser(user);
  }

// HOUSES //////////////////////////////
  getHouses() async {
    await DBProvider.db.getAllHouses().then((lst) => houses = lst);
  }

  getOneHouse(int id) async {
    House _house = await DBProvider.db.getHouse(id);
    return _house;
  }

  deleteHouse(int id) {
    DBProvider.db.deleteHouse(id);
    getHouses();
  }

  addHouse(House client) {
    DBProvider.db.newHouse(client);
    getHouses();
  }

  updateHouse(House client) {
    DBProvider.db.updateHouse(client);
  }

}