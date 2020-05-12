import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:realtyapp/models/agent.dart';
import 'package:realtyapp/models/house.dart';


House clientFromJson(String str) {
  final jsonData = json.decode(str);
  return House.fromMap(jsonData);
}

String clientToJson(House data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class User {
  String uid;

  // required to register
  String firstName;
  String lastName;
  String phoneNumber;
  String email;

  User({this.uid, this.firstName, this.lastName, this.phoneNumber, this.email});
}


class UserData {
  // from firebase
  String uid;

  // required to register
  String firstName;
  String lastName;
  String phoneNumber;
  String email;

  // can be added in user's profile
  House house;
  Agent agent;
  AssetImage profilePicture;

  UserData({this.uid, this.firstName, this.lastName, this.phoneNumber, this.email, this.house, this.agent, this.profilePicture});

  factory UserData.fromMap(Map<String, dynamic> json) => new UserData(
    uid: json["uid"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    house: json["house"],
    agent: json["agent"],
    profilePicture: json["profile_picture"],
  );

  Map<String, dynamic> toMap() => {
    "uid": uid,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "email": email,
    "house": house,
    "agent": agent,
    "profile_picture": profilePicture,
  };

}


//class UserData {
//  // from firebase
//  String uid;
//
//  // required to register
//  String firstName;
//  String lastName;
//  String phoneNumber;
//  String email;
//
//  // can be added in user's profile
//  House house;
//  Agent agent;
//  AssetImage profilePicture;
//
//  UserData({this.uid, this.firstName, this.lastName, this.phoneNumber, this.email, this.house, this.agent, this.profilePicture});
//
//}