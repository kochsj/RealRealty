import 'package:flutter/material.dart';
import 'package:realtyapp/models/custom_nav_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    List<Widget> moreChildren = [];
    for (String name in buttonNames){
      moreChildren.add(MorePageButton(name, Icons.arrow_forward_ios));
    }
    moreChildren.add(MorePageSignOutButton());

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

class MorePageButton extends StatelessWidget {
  final String buttonText;
  final IconData icon;

  MorePageButton(this.buttonText, this.icon);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        width: width,
        padding: EdgeInsets.only(left: 10.0, top: 25.0, bottom: 25.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(icon)),
            Text(buttonText, style: TextStyle(fontSize: 36),),
          ],
        )
    );
  }
}

class MorePageSignOutButton extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return RaisedButton(
        padding: EdgeInsets.only(left: 10.0, top: 25.0, bottom: 25.0),
        onPressed: () async {
          await _auth.signOut();
        },
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.power)),
            Text("Sign Out", style: TextStyle(fontSize: 36),),
          ],
        )
    );
  }
}
