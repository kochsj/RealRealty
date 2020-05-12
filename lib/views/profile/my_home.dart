import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/firestore_db.dart';

//class HouseFormArguments {
//  final User userData;
//  HouseFormArguments(this.userData);
//}

class RegisterMyHome extends StatefulWidget {
  @override
  _RegisterMyHomeState createState() => _RegisterMyHomeState();
}

class _RegisterMyHomeState extends State<RegisterMyHome> {
  final _formKey = GlobalKey<FormState>();

  String _homeAddress = '';
  String _city = '';
  String _state = '';
  String _zipCode = '';

  final List<String> _listOfStateAbrv = [
    '',
    'AL',
    'AK',
    'AZ',
    'AR',
    'CA',
    'CO',
    'CT',
    'DE',
    'FL',
    'GA',
    'HI',
    'ID',
    'IL',
    'IN',
    'IA',
    'KS',
    'KY',
    'LA',
    'ME',
    'MD',
    'MA',
    'MI',
    'MN',
    'MS',
    'MO',
    'MT',
    'NE',
    'NV',
    'NH',
    'NJ',
    'NM',
    'NY',
    'NC',
    'ND',
    'OH',
    'OK',
    'OR',
    'PA',
    'RI',
    'SC',
    'SD',
    'TN',
    'TX',
    'UT',
    'VT',
    'VA',
    'WA',
    'WV',
    'WI',
    'WY'
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

//    print("xxx ${user.house.streetAddress}");
//    print(user.house.city);
//    print(user.house.state);
//    print(user.house.zipCode);

    setState(() {
      _homeAddress = user.house.streetAddress != null ? user.house.streetAddress : '';
      _city = user.house.city != null ? user.house.city : '';
      _state = user.house.state != null ? user.house.state : '';
      _zipCode = user.house.zipCode != null ? user.house.zipCode : '';
    });



    double width = MediaQuery.of(context).size.width;

    List<DropdownMenuItem<String>> _stateList = [];

    for (String state in _listOfStateAbrv) {
      _stateList.add(DropdownMenuItem(
        child: Text(state),
        value: state,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your House', style: TextStyle(fontSize: 28.0)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Looks like we do not have a house on record for you yet. If you would like to add your home please simply fill out the form below!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21.0),
              ),
              SizedBox(
                height: 60.0,
              ),
              Text("What is your home address?"),
              TextFormField(
                decoration: InputDecoration(hintText: _homeAddress),
                initialValue: _homeAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return "please enter your street address";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    _homeAddress = value;
                  });
                },
              ),
              Container(
                width: width,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(hintText: _city),
                        initialValue: _city,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "please enter your home city";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _city = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 60.0,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                        value: _state,
                        items: _stateList,
                        onChanged: (value) {
                          setState(() {
                            _state = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: _zipCode),
                        initialValue: _zipCode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "please enter your home city";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            _zipCode = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Colors.green,
                child: Text("Register", style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    user.house = House(
                      zpid: Random().nextInt(100000000).toString(),
                      streetAddress: _homeAddress,
                      city: _city,
                      state: _state,
                      zipCode: _zipCode,
                    );
                    await UserDatabaseService(uid: user.uid).updateUserData(user);
                    Navigator.of(context).pushReplacementNamed('/profile');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
