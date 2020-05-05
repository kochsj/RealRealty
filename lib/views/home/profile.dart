import 'package:flutter/material.dart';
import 'package:realtyapp/models/custom_nav_bar.dart';
import 'package:realtyapp/models/custom_button.dart';
import 'package:realtyapp/services/auth.dart';

Text profileText() {
  return Text('Profile Page', style: TextStyle(fontSize: 36.0),  textWidthBasis: TextWidthBasis.longestLine,);
}

class ProfilePage extends StatelessWidget {
  final AssetImage profilePic;
  final String fullName;
  final String phoneNumber;
  final String emailAddress;

  ProfilePage(this.fullName, this.phoneNumber, this.emailAddress, [this.profilePic = example]);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.amber,
      body: ListView(
        children: <Widget>[
          ProfileHeader(profilePic, fullName, phoneNumber, emailAddress),
          ProfileBody(),
        ],
      ),

//      body: Column(
//        children: <Widget>[
//          ProfileHeader(profilePic, fullName, phoneNumber, emailAddress),
//          ProfileBody(),
//
//        ],
//      ),
      bottomNavigationBar: MyCustomNavBar(),
    );

  }
}


class ProfileHeader extends StatelessWidget {
  final AuthService _auth = AuthService();

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
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}
const AssetImage example = AssetImage("media/emoji.png");

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        color: Colors.amber,
        width: width,
        child: Column(
          children: <Widget>[
            YourAgentRow(),
            YourHomeRow(),
            ProfilePageButton("Preferences", Icons.account_circle),
            ProfilePageButton("Settings", Icons.settings),
            ProfilePageButton("My Documents", Icons.archive)

          ],
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