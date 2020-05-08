import 'package:flutter/material.dart';
import 'package:realtyapp/models/house_model.dart';
import 'package:realtyapp/models/custom_nav_bar.dart';
import 'package:realtyapp/models/database.dart';

Text favoritesText() {
  return Text('My Favorites Page', style: TextStyle(fontSize: 36.0),  textWidthBasis: TextWidthBasis.longestLine,);
}


class FavoritesPage extends StatefulWidget {
  final bloc;
  FavoritesPage(this.bloc);

  @override
  FavoritesState createState() {
    return FavoritesState(bloc, Center(child: CircularProgressIndicator()));
//    return FavoritesState(Center(child: CircularProgressIndicator()));
  }
}

class FavoritesState extends State<FavoritesPage> {
  final bloc;
  Widget _view;
  FavoritesState(this.bloc, this._view);
//  FavoritesState(this._view);

  @override
  void initState() {
    _view = Center(child: CircularProgressIndicator());

    _checkDB();
  }

  void _removeFromDB(int id) async {
    await bloc.deleteHouse(id);
    await bloc.getHouses();

    List<House> _clients = bloc.houses;

    setState(() {
      _view = FavoritesPageItemWidget(_clients, _removeFromDB);
    });
  }

  void _checkDB() async {
    List<House> _clients = bloc.houses != null ? bloc.houses : [];

    setState(() {
      _view = FavoritesPageItemWidget(_clients, _removeFromDB);
    });
  }

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
  final List<House> _clients;
  final Function _callback;

  FavoritesPageItemWidget(this._clients, this._callback);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _clients.length,
        itemBuilder: (context, index) {
          House item = _clients[index];
          return ListTile(
            title: Text(item.streetAddress),
            leading: Text(item.id.toString()),
            trailing: FlatButton(
              child: Icon(Icons.delete),
              onPressed: () {
                _callback(item.id);
              },
            ),
          );
        });
  }
}


