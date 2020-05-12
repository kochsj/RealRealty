import 'package:flutter/material.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/views/home/detail.dart';


class HouseListTile extends StatelessWidget {
  final House house;
  final bool isMyHouse;
  HouseListTile({this.house, this.isMyHouse});

//  @override
//  Widget build(BuildContext context) {
//    double width = MediaQuery.of(context).size.width;
//    return customHouseListTileButton(context, house, width);
//  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Widget myHomeHeader = Container();

    if(isMyHouse) {
      myHomeHeader = Container(
        decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(8.0),),
        child: Row(
          children: <Widget>[
            Icon(Icons.home),
            Padding(padding: EdgeInsets.only(left: 12.0),),
            Text("My Home", style: TextStyle(fontSize: 36),),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        print("its your house!");
        Navigator.pushNamed(context, '/detail', arguments: ScreenArguments(house));
      },
      //custom button
      child: Container(
        margin: EdgeInsets.all(10.0),
//        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        width: width,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            image: DecorationImage(
//            image: AssetImage("media/house_for_sale.jpg"),
              image: NetworkImage("https://wp-tid.zillowstatic.com/3/shutterstock_50097079-2ec9cc-630x420.jpg"),
              fit: BoxFit.cover,
            ),
            color: Colors.orange,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black)
        ),
        child: Column(
          children: <Widget>[
            myHomeHeader,
            SizedBox(height: 20.0,),
            Container(
              decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(8.0)),
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 20.0),),
                  Text(house.streetAddress),
                ],
              ),
            ),
          ],),
      ),
    );
  }
}

GestureDetector customHouseListTileButton(BuildContext context, House house, double width) {

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


