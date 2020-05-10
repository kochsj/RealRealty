import 'package:flutter/material.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';
import 'package:realtyapp/shared_widgets/custom_button.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/auth.dart';
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
            UserData userData = snapshot.data;


            return Scaffold(
              backgroundColor: Colors.amber,
              body: ListView(
                children: <Widget>[
                  ProfileHeader(userData),
                  ProfileBody(userData),
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

  final UserData _userData;

  ProfileHeader(this._userData);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    String fullName = _userData.firstName + ' ' + _userData.lastName;
    String phoneNumber = _userData.phoneNumber;
    String emailAddress = _userData.email;

    AssetImage _profilePic;

    if(_userData.profilePicture == null) {
      _profilePic = example;
    } else {
      _profilePic = _userData.profilePicture;
    }

    return Container(
      color: Colors.orange,
      padding: EdgeInsets.only(top: 80.0, bottom: 20.0),
      width: width,
      child: Column(
        children: <Widget>[
          ProfileImage(_profilePic),
          Text(fullName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0,)),
          Text(phoneNumber,),
          Text(emailAddress),
        ],
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {

  final UserData _userData;

  ProfileBody(this._userData);

  void _signOut() async {
    await AuthService().signOut();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Widget usersHomeRow;

    if(_userData.house == null) {
      usersHomeRow = Container();
    } else {
// TODO: how to store a user's house in the DB?
      usersHomeRow = UsersHomeRow(_userData.house);
    }

    return Container(
        color: Colors.amber,
        width: width,
        child: Column(
          children: <Widget>[
            UsersAgentRow(),
            usersHomeRow,
            customListMenuButton(context, "Preferences", width, Icons.account_circle),
            customListMenuButton(context, "Settings", width, Icons.settings),
            customListMenuButton(context, "My Documents", width, Icons.archive),
            customListMenuButton(context, "Sign Out", width, Icons.settings_power, _signOut),
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

class UsersAgentRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
//      TODO: agent route/view (?)
        print("go to agent");
//      Navigator.pushNamed(context, '/detail', arguments: ScreenArguments(house));
      },
      //custom button
      child: Container(
          width: width,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black)
          ),
//      child: Text(buttonText),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.email),
                  Padding(padding: EdgeInsets.only(left: 12.0),),
                  Text("My Agent", style: TextStyle(fontSize: 36),),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 40.0),),
                  // TODO: add real agent info
                  Text("~ Samantha Hill - Real Realty", style: TextStyle(fontSize: 20.0),)
                ],
              ),
            ],),
      ),
    );
  }
}

class UsersHomeRow extends StatelessWidget {
  final House usersHouse;
  UsersHomeRow(this.usersHouse);

//  TODO: Populate with your current home info

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      child: Row(
        children: <Widget>[
          Text("Your Home:"),
          Icon(Icons.home),
          Text("123 Main Street")
        ],
      ),
    );
  }
}

