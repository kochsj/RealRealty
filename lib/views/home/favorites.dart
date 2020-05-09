import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/firestore_db.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';
import 'package:realtyapp/services/local_db.dart';
import 'package:realtyapp/shared_widgets/loading.dart';

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
    final user = Provider.of<User>(context);

    return StreamBuilder<List<House>>(
        stream: FavoritesDatabaseService(uid: user.uid).favoriteHouses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<House> houses = snapshot.data;

            return Scaffold(
              appBar: AppBar(
              title: Text('Favorites', style: TextStyle(fontSize: 28.0)),
              ),
              body: ListView.builder(
                  itemCount: houses.length,
                  itemBuilder: (context, index){
                    return FavoriteTile(favoriteHouse: houses[index]);
                  }),
              bottomNavigationBar: MyCustomNavBar(),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.amber,
              body: Container(
                child: LoadingWidget(),
              ),
              bottomNavigationBar: MyCustomNavBar(),
            );
          }
        }
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


class FavoritesTile extends StatelessWidget {
  final favoriteHouse;
  FavoritesTile(this.favoriteHouse);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
