import 'package:flutter/material.dart';

class RecentlyViewedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recently Viewed', style: TextStyle(fontSize: 28.0)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Here is some recently viewed info..."),
          ],
        ),
      ),
//      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
