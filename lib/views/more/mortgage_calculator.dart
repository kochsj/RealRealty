import 'package:flutter/material.dart';

class MortgageCalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator Page', style: TextStyle(fontSize: 28.0)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Here is some calculator info..."),
          ],
        ),
      ),
//      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
