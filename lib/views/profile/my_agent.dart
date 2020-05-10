import 'package:flutter/material.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';

class MyAgentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agent Page', style: TextStyle(fontSize: 28.0)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Here is some agent info..."),
          ],
        ),
      ),
//      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
