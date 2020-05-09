import 'package:flutter/material.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';
import 'package:realtyapp/services/local_db.dart';

Text favoritesText() {
  return Text('My Favorites Page', style: TextStyle(fontSize: 36.0),  textWidthBasis: TextWidthBasis.longestLine,);
}


class FavoritesPage extends StatefulWidget {
  @override
  FavoritesState createState() {
    return FavoritesState();
//    return FavoritesState(Center(child: CircularProgressIndicator()));
  }
}

class FavoritesState extends State<FavoritesPage> {

  Widget _view = Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites', style: TextStyle(fontSize: 28.0)),
      ),
      body: _view,
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


