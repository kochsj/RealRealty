import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/firestore_db.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';

class MyAgentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: UserDatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            if (snapshot.data.agent != null) {
              return Scaffold(
                backgroundColor: Colors.orange,
                body: ListView(
                  children: <Widget>[
                    Text("heres your agent")
                  ]
                ),
              );
            }
          }

          print("no data......");
          return Scaffold(
            backgroundColor: Colors.orange,
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Oops..."),
                    Text("It looks like you do not have an agent with us yet.", style: TextStyle(), textAlign: TextAlign.center,),
                    SizedBox(height: 100.0,),
                    Text("Would you like to be contacted about finding the right agent for you?", style: TextStyle(), textAlign: TextAlign.center,),
                    SizedBox(height: 10.0,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () async {
                              print("yes");
                            },
                            child: Text("Yes",),
                          ), SizedBox(width: 20.0,),
                          RaisedButton(
                            onPressed: () async {
                              print("no");
                            },
                            child: Text("No"),
                          )
                        ],
                      ),
                    )


                  ],
                ),
              )
            )
          );
        }
    );
  }
}
