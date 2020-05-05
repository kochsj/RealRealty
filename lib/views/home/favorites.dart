import 'package:flutter/material.dart';
import 'package:realtyapp/models/client_model.dart';
import 'package:realtyapp/models/custom_nav_bar.dart';
import 'package:realtyapp/models/database.dart';

Text favoritesText() {
  return Text('My Favorites Page', style: TextStyle(fontSize: 36.0),  textWidthBasis: TextWidthBasis.longestLine,);
}

List<Client> testClients = [
  Client(firstName: "Raouf", lastName: "Rahiche", blocked: 0),
  Client(firstName: "Zaki", lastName: "oun", blocked: 1),
  Client(firstName: "oussama", lastName: "ali", blocked: 0),
];

class FavoritesPage extends StatefulWidget {
//  final bloc;
//  FavoritesPage(this.bloc);

  @override
  FavoritesState createState() {
//    return FavoritesState(bloc, Center(child: CircularProgressIndicator()));
    return FavoritesState(Center(child: CircularProgressIndicator()));

  }
}

class FavoritesState extends State<FavoritesPage> {
//  final bloc;
  Widget _view;
//  FavoritesState(this.bloc, this._view);
  FavoritesState(this._view);

//  @override
//  void initState() {
//    _view = Center(child: CircularProgressIndicator());
//
//    _checkDB();
//  }
//
//  void _checkDB() async {
//    List<Client> _clients = bloc.clients;
//
//
//    setState(() {
//      _view = FavoritesPageItemWidget(_clients);
//    });
//
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites', style: TextStyle(fontSize: 28.0)),
      ),
      body: _view,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          DBProvider.db.deleteAll();
          setState(() {});
        },
      ),
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}

class FavoritesPageItemWidget extends StatelessWidget {
  final List<Client> _clients;

  FavoritesPageItemWidget(this._clients);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _clients.length,
        itemBuilder: (context, index) {
          Client item = _clients[index];
          return ListTile(
            title: Text(item.firstName),
            leading: Text(item.id.toString()),
            trailing: Checkbox(value: item.blocked == 1,),
          );
        });
  }
}


