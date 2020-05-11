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

  void _signOut() async {
    await AuthService().signOut();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

//    List<Widget> moreChildren = [];
//    for (String name in buttonNames){
//      moreChildren.add(customListMenuButton(context, name, width));
//    }
//    moreChildren.add(customListMenuButton(context, 'Sign Out', width, Icons.settings_power, '', _signOutFunction));

    return Scaffold(
      appBar: AppBar(
        title: Text('More Relator', style: TextStyle(fontSize: 28.0)),
      ),
      body: ListView(
        children: <Widget>[
          CustomListMenuButton(
//            context: context,
            buttonText: "Recently Viewed",
            width: width,
            routeName: '/more/recent',
          ),
          CustomListMenuButton(
//            context: context,
            buttonText: "Our Team",
            width: width,
            routeName: '/more/ourteam',
          ),
          CustomListMenuButton(
//            context: context,
            buttonText: "Mortgage Calculator",
            width: width,
            routeName: '/more/calculator',
          ),
          CustomListMenuButton(
//            context: context,
            buttonText: "Contact Us",
            width: width,
            routeName: '/more/contactus',
          ),
          CustomListMenuButton(
            buttonText: "Settings",
            width: width,
            icon: Icons.settings,
            routeName: '/profile/settings',
          ),
          CustomListMenuButton(
//            context: context,
            buttonText: "Sign Out",
            width: width,
            icon: Icons.settings_power,
            callback: _signOut,
          ),
        ],
      ),
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}



