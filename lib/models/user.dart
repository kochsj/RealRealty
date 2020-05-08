import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:realtyapp/models/agent.dart';
import 'package:realtyapp/models/house_model.dart';


House clientFromJson(String str) {
  final jsonData = json.decode(str);
  return House.fromMap(jsonData);
}

String clientToJson(House data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}


class User {
  int id;
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
  Image profilePicture;

  User({this.id, this.uid, this.firstName, this.lastName, this.phoneNumber, this.email, this.house, this.agent, this.profilePicture});

  factory User.fromMap(Map<String, dynamic> json) => new User(
    id: json["id"],
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
    "id": id,
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