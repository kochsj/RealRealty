import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/firestore_db.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';
import 'package:realtyapp/shared_widgets/loading.dart';
import 'package:realtyapp/views/home/detail.dart';

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
                    return FavoritesTile(favoriteHouse: houses[index]);
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


GestureDetector customFavoritesTileButton(BuildContext context, House house, double width) {

  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/detail', arguments: ScreenArguments(house));
    },
    //custom button
    child: Container(
      width: width,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black)
      ),
      child: Text(house.streetAddress),
    ),
  );
}


class FavoritesTile extends StatelessWidget {
  final favoriteHouse;
  FavoritesTile({this.favoriteHouse});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return customFavoritesTileButton(context, favoriteHouse, width);
  }
}
