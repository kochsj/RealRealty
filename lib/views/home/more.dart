import 'package:flutter/material.dart';
import 'package:realtyapp/shared_widgets/custom_button.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';
import 'package:realtyapp/services/auth.dart';

Text moreText() {
  return Text('More Page', style: TextStyle(fontSize: 36.0),  textWidthBasis: TextWidthBasis.longestLine,);
}

class MorePage extends StatelessWidget {

  final List<String> buttonNames = [
    'Recently Viewed',
    'Our Team',
    'Mortgage Calculator',
    'Contact Us',
  ];

  void _signOutFunction() async {
    await AuthService().signOut();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<Widget> moreChildren = [];
    for (String name in buttonNames){
      moreChildren.add(customListMenuButton(context, name, width));
    }
    moreChildren.add(customListMenuButton(context, 'Sign Out', width, Icons.settings_power, _signOutFunction));

    return Scaffold(
      appBar: AppBar(
        title: Text('More Relator', style: TextStyle(fontSize: 28.0)),
      ),
      body: ListView(
        children: moreChildren,
      ),
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}



