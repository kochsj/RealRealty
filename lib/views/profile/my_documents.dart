import 'package:flutter/material.dart';

class MyDocumentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Documents Page', style: TextStyle(fontSize: 28.0)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Here is some document info..."),
            ],
          ),
        ),
    );
//      bottomNavigationBar: MyCustomNavBar(),
  }
}
