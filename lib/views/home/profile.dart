import 'package:flutter/material.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';
import 'package:realtyapp/shared_widgets/custom_button.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/services/firestore_db.dart';
import 'package:realtyapp/shared_widgets/loading.dart';

Text profileText() {
  return Text('Profile Page', style: TextStyle(fontSize: 36.0),  textWidthBasis: TextWidthBasis.longestLine,);
}

const AssetImage example = AssetImage("media/emoji.png");

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: UserDatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData ud = snapshot.data;
            String fullName = ud.firstName + ' ' + ud.lastName;

            return Scaffold(
              backgroundColor: Colors.amber,
              body: ListView(
                children: <Widget>[
                  ProfileHeader(example, fullName, ud.phoneNumber, ud.email),
                  ProfileBody(),
                ],
              ),

              bottomNavigationBar: MyCustomNavBar(),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.amber,
              body: Container(
                child: LoadingWidget(),
              ),
              bottomNavigationBar: MyCustomNavBar(),
            );
          }
        }
    );
  }
}

class ProfileHeader extends StatelessWidget {

  final AssetImage profilePic;
  final String fullName;
  final String phoneNumber;
  final String emailAddress;

  ProfileHeader(this.profilePic, this.fullName, this.phoneNumber, this.emailAddress);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.orange,
      padding: EdgeInsets.only(top: 80.0, bottom: 20.0),
      width: width,
      child: Column(
        children: <Widget>[
          ProfileImage(profilePic),
          Text(fullName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0,)),
          Text(phoneNumber,),
          Text(emailAddress),
        ],
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  final AuthService _auth = AuthService();

  void signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        color: Colors.amber,
        width: width,
        child: Column(
          children: <Widget>[
            customListMenuButton(context, "Preferences", width, Icons.account_circle),
            customListMenuButton(context, "Settings", width, Icons.settings),
            customListMenuButton(context, "My Documents", width, Icons.archive),
            customListMenuButton(context, "Sign Out", width, Icons.settings_power, signOut),
          ],
//          children: <Widget>[
//            YourAgentRow(),
//            YourHomeRow(),
//            ProfilePageButton("Preferences", Icons.account_circle),
//            ProfilePageButton("Settings", Icons.settings),
//            ProfilePageButton("My Documents", Icons.archive),
//            IconButton(
//              icon: Icon(Icons.settings),
//              onPressed: () async {
//                await _auth.signOut();
//              },
//            )
//
//          ],
        )
    );
  }
}

class ProfileImage extends StatelessWidget {
  final AssetImage profilePic;

  ProfileImage(this.profilePic);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      width: 200.0,
      height: 200.0,
      decoration: new BoxDecoration(
//        color: Colors.orange,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: profilePic,
            fit: BoxFit.contain,
          )
      ),
    );
  }
}

class YourAgentRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      child : Row(
        children: <Widget>[
          IconButton(icon: Icon(Icons.email)),
          Text("Sammantha Hill", style: TextStyle(fontSize: 36),),
        ],
      ),
    );
  }
}

class YourHomeRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      child: Row(
        children: <Widget>[
          Text("Your Home:"),
          IconButton(icon: Icon(Icons.home)),
          Text("123 Main Street")
        ],
      ),
    );
  }
}

class ProfilePageButton extends StatelessWidget {
  final String buttonText;
  final IconData icon;

  ProfilePageButton(this.buttonText, this.icon);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        width: width,
        padding: EdgeInsets.only(left: 10.0, top: 25.0, bottom: 25.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(icon)),
            Text(buttonText, style: TextStyle(fontSize: 36),),
          ],
        )
    );
  }
}