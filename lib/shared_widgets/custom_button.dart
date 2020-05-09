import 'package:flutter/material.dart';

import '../models/house.dart';

GestureDetector customButton(BuildContext context, House house, double top, double left, [callback]) {
  return GestureDetector(
    onTap: () {
      callback(house);
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

class NavButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final String route;

  NavButton(this.name, this.icon, this.route);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: IconButton(
              icon: Icon(icon),
              onPressed: () {
                Navigator.pushReplacementNamed(context, route);
              }),
          height: 37,
        ),
        Text('$name', style: TextStyle(fontSize: 12),),
      ],
    );
  }
}