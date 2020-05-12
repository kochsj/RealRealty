import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/models/agent.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/firestore_db.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';

class MyAgentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    return StreamBuilder<UserData>(
        stream: UserDatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData;
          Agent agent;

          if (snapshot.hasData) {
            userData = snapshot.data;

            if (snapshot.data.agent != null) {
              agent = snapshot.data.agent;

              return Scaffold(
                backgroundColor: Colors.orange,
                appBar: AppBar(
                  title: Text("YOUR AGENT"),
                ),
                body: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 80.0, bottom: 20.0),
                  child: Column(
                    children: <Widget>[
                      Text("Name: ${agent.firstName} ${agent.lastName}"),
                      Text("Phone: ${agent.phoneNumber}"),
                      Text("Email: ${agent.email}"),
                      Text("Company: ${agent.company}"),
                    ],
                  ),
                )
              );
            }
          }
          return Scaffold(
            backgroundColor: Colors.orange,
            appBar: AppBar(
              title: Text("YOUR AGENT"),
            ),
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

                              //TODO: ask a few questions... what area do you want to live in? what are you looking for?
                              // instead of forcing an agent like in test case


                              userData.agent = Agent(
                                firstName: "Samantha",
                                lastName: "TestCase",
                                phoneNumber: "4258675309",
                                email: "samantha@test.test",
                                company: "Real Realty",
                              );
                              await UserDatabaseService(uid: userData.uid).updateUserData(userData);
                            },
                            child: Text("Yes",),
                          ), SizedBox(width: 20.0,),
                          RaisedButton(
                            onPressed: () async {
                              print("no");
                              Navigator.of(context).pushReplacementNamed("/profile");
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
