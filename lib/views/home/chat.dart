import 'package:flutter/material.dart';
import 'package:realtyapp/models/custom_nav_bar.dart';


Text chatText(){
  return Text('Chat Page', style: TextStyle(fontSize: 36.0),  textWidthBasis: TextWidthBasis.longestLine,);
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page', style: TextStyle(fontSize: 28.0)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            chatText(),
          ],
        ),
      ),
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}