import 'package:flutter/material.dart';
import 'package:realtyapp/models/custom_button.dart';
import 'package:realtyapp/models/custom_nav_bar.dart';
import 'detail.dart';



class SearchView extends StatefulWidget {
  final bloc;
  SearchView(this.bloc);

  @override
  SearchState createState() {
    return SearchState(bloc);
//    return SearchState();
  }
}

class SearchState extends State<SearchView> {
  final listOfHouses = ['123 Main St', '54 Park Ave', '701 Stewart St'];
  final bloc;

  SearchState(this.bloc);



  void _changeToDetailView(String str) {
//    Navigator.pushNamed(context, '/detail',);

    Navigator.pushNamed(context, '/detail', arguments: ScreenArguments(str, bloc));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];
    double top = 10;
    double left = 300;
    for(var i in listOfHouses) {
      top += 70;
      left -= 60;
      buttons.add(customButton(context, '$i', top, left, _changeToDetailView));
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
        child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buttons,

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