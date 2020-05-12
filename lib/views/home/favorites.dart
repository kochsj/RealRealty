import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/firestore_db.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';
import 'package:realtyapp/shared_widgets/house_list_tile.dart';
import 'package:realtyapp/shared_widgets/loading.dart';

Text favoritesText() {
  return Text('My Favorites Page', style: TextStyle(fontSize: 36.0),  textWidthBasis: TextWidthBasis.longestLine,);
}


class FavoritesPage extends StatefulWidget {
  @override
  FavoritesState createState() {
    return FavoritesState();
  }
}

class FavoritesState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

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
                    return HouseListTile(house: houses[index], isMyHouse: false);
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

