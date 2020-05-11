import 'package:flutter/material.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';
import 'package:realtyapp/shared_widgets/custom_button.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/services/firestore_db.dart';
import 'package:realtyapp/shared_widgets/house_list_tile.dart';
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
              backgroundColor: Colors.orange,
              body: ListView(
                children: <Widget>[
                  ProfileHeader(userData),
                  ProfileBody(userData),
                ],
              ),
              floatingActionButton: FloatingActionButton(onPressed: () async {
                userData.house = House(
                  zpid: "58729009957732",
                  streetAddress: "2113 4th Ave",
                  city: "Everett",
                  state: "WA",
                  zipCode: "98201",
                );
                await UserDatabaseService(uid: userData.uid).updateUserData(userData);
              },),
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
      usersHomeRow = UsersHomeRow(null);
    } else {
      usersHomeRow = UsersHomeRow(_userData.house);
    }

    return Container(
        color: Colors.amber,
        width: width,
        child: Column(
          children: <Widget>[
            usersHomeRow,
            UsersAgentRow(_userData),
            CustomListMenuButton(
              buttonText: "Preferences",
              width: width,
              icon: Icons.account_circle,
              routeName: '/profile/preferences',
            ),
            CustomListMenuButton(
              buttonText: "My Documents",
              width: width,
              icon: Icons.archive,
              routeName: '/profile/documents',
            ),
//            CustomListMenuButton(
//              buttonText: "Sign Out",
//              width: width,
//              icon: Icons.settings_power,
//              callback: _signOut,
//            ),
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
  final UserData _userData;

  UsersAgentRow(this._userData);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Widget agentSnapshot = Container();


    if(_userData.agent != null){
      agentSnapshot = _userData.agent.company != null ? Text("~ ${_userData.agent.firstName} ${_userData.agent.lastName} - ${_userData.agent.company}", style: TextStyle(fontSize: 20.0)) : Text("~ ${_userData.agent.firstName} ${_userData.agent.lastName}", style: TextStyle(fontSize: 20.0));
    }

    return GestureDetector(
      onTap: () {
//      TODO: agent route/view (?)
        print("go to agent");
        Navigator.of(context).pushNamed('/profile/agent');
//      Navigator.pushNamed(context, '/detail', arguments: ScreenArguments(house));
      },
      //custom button
      child: Container(
        margin: EdgeInsets.all(10.0),
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
                  agentSnapshot,
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

    // if there is a users house, i want there to be tile similar but different than the House list tile
    Widget houseSnapshot = usersHouse != null ? MyHomeTile(myHome: usersHouse,) : NoHomeTile();

    return houseSnapshot;
  }
}


class NoHomeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        print("going to no home");
        // TODO: how to store a user's house in the DB?
        // TODO: render page with form
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
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
                Icon(Icons.home),
                Padding(padding: EdgeInsets.only(left: 12.0),),
                Text("My Home", style: TextStyle(fontSize: 36),),
              ],
            ),
          ],),
      ),
    );
  }
}

class MyHomeTile extends StatelessWidget {
  final House myHome;
  MyHomeTile({this.myHome});
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        print("its your house!");
//        Navigator.pushNamed(context, '/detail', arguments: ScreenArguments(house));
      },
      //custom button
      child: Container(
        margin: EdgeInsets.all(10.0),
//        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        width: width,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("media/house_for_sale.jpg"),
            fit: BoxFit.cover,
          ),
          color: Colors.orange,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black)
        ),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(8.0),),
              child: Row(
                children: <Widget>[
                  Icon(Icons.home),
                  Padding(padding: EdgeInsets.only(left: 12.0),),
                  Text("My Home", style: TextStyle(fontSize: 36),),
                ],
              ),
            ),
//            Row(
//              children: <Widget>[
//                Icon(Icons.home),
//                Padding(padding: EdgeInsets.only(left: 12.0),),
//                Container(
//                  decoration: BoxDecoration(color: Colors.white54),
//                  child: Text("My Home", style: TextStyle(fontSize: 36),),
//                )
//              ],
//            ),
            SizedBox(height: 20.0,),
            Container(
              decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(8.0)),
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 20.0),),
                  Text(myHome.streetAddress),
                ],
              ),
            ),
          ],),
      ),
    );
  }
}

