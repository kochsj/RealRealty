import 'package:flutter/cupertino.dart';
import 'package:realtyapp/models/agent.dart';
import 'package:realtyapp/models/house_model.dart';

class User {
  // from firebase
  final String uid;

  // required to register
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;

  // can be added in user's profile
  House house;
  Agent agent;
  Image profilePicture;

  User({this.uid, this.firstName, this.lastName, this.phoneNumber, this.email});

}