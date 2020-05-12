import 'package:flutter/material.dart';
import 'package:realtyapp/shared_widgets/custom_button.dart';
import 'package:realtyapp/views/profile/my_home.dart';

class ProfilePreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences Page', style: TextStyle(fontSize: 28.0)),
      ),
      body: ListView(
        children: <Widget>[
          CustomListMenuButton(buttonText: "Update \"My Home\"", routeName: '/profile/myhome')
        ],
      )
//      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
