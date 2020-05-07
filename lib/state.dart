import 'dart:async';
import 'models/house_model.dart';
import 'models/database.dart';


class ClientsBloc {
  ClientsBloc() {
    getClients();
  }

  List<House> clients;

  getClients() async {
    await DBProvider.db.getAllClients().then((lst) => clients = lst);
  }

  House getOneClient(int id) {
    House _client = DBProvider.db.getClient(id);
    return _client;
  }

  delete(int id) {
    DBProvider.db.deleteClient(id);
    getClients();
  }

  add(House client) {
    DBProvider.db.newClient(client);
    getClients();
  }

  update(House client) {
    DBProvider.db.updateClient(client);
  }

}