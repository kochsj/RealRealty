import 'package:flutter/material.dart';

class ProfilePreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences Page', style: TextStyle(fontSize: 28.0)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Here is some preferences info..."),
          ],
        ),
      ),
//      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
