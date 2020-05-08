import 'dart:async';
import 'package:realtyapp/models/user.dart';

import 'models/house_model.dart';
import 'models/database.dart';


class ClientsBloc {
  ClientsBloc() {
    getHouses();
  }

  List<House> houses;
  String currentUID;

// USER(S) //////////////////////////////
  getUser(int id) async {
    User _user = DBProvider.db.getUser(id);
    currentUID = _user.uid;
    return _user;
  }

  deleteUser(int id) {
    DBProvider.db.deleteUser(id);
  }

  addUser(User user) {
    DBProvider.db.newUser(user);
    currentUID = user.uid;
  }

  updateUser(User user) {
    DBProvider.db.updateUser(user);
  }

// HOUSES //////////////////////////////
  getHouses() async {
    await DBProvider.db.getAllHouses().then((lst) => houses = lst);
  }

  House getOneHouse(int id) {
    House _house = DBProvider.db.getHouse(id);
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