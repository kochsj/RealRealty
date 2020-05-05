import 'dart:async';
import 'models/client_model.dart';
import 'models/database.dart';


class ClientsBloc {
  ClientsBloc() {
    getClients();
  }

  List<Client> clients;

  getClients() async {
    await DBProvider.db.getAllClients().then((lst) => clients = lst);
  }

  Client getOneClient(int id) {
    Client _client = DBProvider.db.getClient(id);
    return _client;
  }

  delete(int id) {
    DBProvider.db.deleteClient(id);
    getClients();
  }

  add(Client client) {
    DBProvider.db.newClient(client);
    getClients();
  }

  update(Client client) {
    DBProvider.db.updateClient(client);
  }

}