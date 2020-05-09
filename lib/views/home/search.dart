import 'package:flutter/material.dart';
import 'package:realtyapp/shared_widgets/custom_button.dart';
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
    House(streetAddress: '123 Main St', state: 'WA', city: 'Woodinville', zipCode: '98072'),
    House(streetAddress: '54 Park Ave', state: 'WA', city: 'Woodinville', zipCode: '98071'),
    House(streetAddress: '701 Stewart St', state: 'WA', city: 'Woodinville', zipCode: '98073'),
  ];


  void _changeToDetailView(House houseToView) {
//    Navigator.pushNamed(context, '/detail',);

    Navigator.pushNamed(context, '/detail', arguments: ScreenArguments(houseToView));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];
    double top = 10;
    double left = 300;
    for(House i in listOfHouses) {
      top += 70;
      left -= 60;
      buttons.add(customButton(context, i, top, left, _changeToDetailView));
    }

    Scaffold searchScaffold = Scaffold(
//      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('~ MOVIL REALTY ~', style: TextStyle(fontSize: 28.0),),
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
//      body: Center(
//        child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: buttons,
//      ),
//    ),
      bottomNavigationBar: MyCustomNavBar(),
    );

    return searchScaffold;

  }
}