import 'package:flutter/material.dart';

class OurTeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our team Page', style: TextStyle(fontSize: 28.0)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Here is some our team info..."),
          ],
        ),
      ),
//      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
