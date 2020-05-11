import 'package:flutter/material.dart';
import 'custom_button.dart';

class MyCustomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          NavButton('Search', Icons.search, '/'),
          NavButton('Favorites', Icons.favorite_border, '/favorites'),
          NavButton('Your Home', Icons.pin_drop, '/profile'),
          NavButton('Chat', Icons.chat_bubble_outline, '/chat'),
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