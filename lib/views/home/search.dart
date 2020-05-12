import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/firestore_db.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';
import 'package:realtyapp/models/house.dart';
import 'detail.dart';


class SearchView extends StatefulWidget {
  @override
  SearchState createState() {
    return SearchState();
  }
}

class SearchState extends State<SearchView> {
  final listOfHouses = [
    House(streetAddress: '123 Main St', state: 'WA', city: 'Woodinville', zipCode: '98072', zpid: "1234567890"),
    House(streetAddress: '54 Park Ave', state: 'WA', city: 'Woodinville', zipCode: '98071', zpid: "0987654321"),
    House(streetAddress: '701 Stewart St', state: 'WA', city: 'Woodinville', zipCode: '98073', zpid: "10293948576"),
  ];

  List<Widget> _constructListOfHouseButtons(UserData user, List<House> houses){

    List<Widget> buttons = [];
    double top = 10;
    double left = 300;

    for(House house in listOfHouses) {
      top += 70;
      left -= 60;
      buttons.add(customSearchViewHouseButton(user, house, top, left, _onClickHouseHandler, houses));
    }

    return buttons;
  }

  void _onClickHouseHandler(UserData user, House houseToView, List<House> listOfRecentlyViewedHouses){
    _updateListOfRecentlyViewedHousesInDB(user, houseToView, listOfRecentlyViewedHouses);
    _changeToDetailView(houseToView);
  }

  void _updateListOfRecentlyViewedHousesInDB(UserData user, House houseToView, List<House> listOfRecentlyViewedHouses) async {
    listOfRecentlyViewedHouses.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
    while(listOfRecentlyViewedHouses.length >= 20) {
      House houseToRemove = listOfRecentlyViewedHouses.removeAt(0);
      await RecentlyViewedService(uid: user.uid).deleteUsersRecentlyViewed(houseToRemove);
    }
    await RecentlyViewedService(uid: user.uid).updateUsersRecentlyViewedData(houseToView);
  }

  void _changeToDetailView(House houseToView) {
    Navigator.of(context).pushNamed('/detail', arguments: ScreenArguments(houseToView));
  }



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final userData = Provider.of<UserData>(context);
    List<Widget> buttons = [];

    return StreamBuilder<List<House>>(
        stream: RecentlyViewedService(uid: user.uid).recentlyViewedHouses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<House> houses = snapshot.data;
            buttons = _constructListOfHouseButtons(userData, houses);
          }
          else {
            buttons = _constructListOfHouseButtons(userData, []);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('~ REAL REALTY ~', style: TextStyle(fontSize: 28.0),),
            ),
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("media/thread-12256607-10980366431130375081.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: buttons,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: MyCustomNavBar(),
          );;
        }
    );
  }
}

GestureDetector customSearchViewHouseButton(UserData user, House house, double top, double left, callback, [List<House> listOfRecentlyViewedHouses,]) {
  return GestureDetector(
    onTap: () {
      List<House> lst = listOfRecentlyViewedHouses != null ? listOfRecentlyViewedHouses : [];
      callback(user, house, lst);
    },
    // The custom button
    child: Container(
      margin: EdgeInsets.only(top: top, left: left),
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