import 'package:flutter/material.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/views/home/detail.dart';


class HouseListTile extends StatelessWidget {
  final house;
  HouseListTile({this.house});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return customHouseListTileButton(context, house, width);
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


