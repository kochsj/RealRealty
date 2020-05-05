import 'package:flutter/material.dart';
import 'custom_button.dart';

class MyCustomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          NavButton('Home', Icons.home, '/'),
          NavButton('Favorite', Icons.favorite, '/favorites'),
          NavButton('Profile', Icons.add_circle, '/profile'),
          NavButton('Chat', Icons.chat_bubble, '/chat'),
          NavButton('More', Icons.list, '/more'),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      height: 90,
      padding: EdgeInsets.only(top: 5, bottom: 10),
      color: Colors.orange,


    );
  }
}