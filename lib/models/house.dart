import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../services/local_db.dart';

House clientFromJson(String str) {
  final jsonData = json.decode(str);
  return House.fromMap(jsonData);
}

String clientToJson(House data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class House {
  int id;
  String zpid;
  String streetAddress;
  String city;
  String state;
  String zipCode;
  String photoURL;
  String beds;
  String baths;
  int timeStamp;

  House({
    this.id,
    this.zpid,
    this.streetAddress,
    this.city,
    this.state,
    this.zipCode,
    this.photoURL,
    this.beds,
    this.baths,
    this.timeStamp,
  });

  factory House.fromMap(Map<String, dynamic> json) => new House(
        id: json["id"],
        zpid: json["zpid"],
        streetAddress: json["street_address"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
        photoURL: json["photo_url"],
        beds: json["beds"],
        baths: json["baths"],
        timeStamp: json["time_stamp"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "zpid": zpid,
        "street_address": streetAddress,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "photo_url": photoURL,
        "beds": beds,
        "baths": baths,
        "time_stamp": timeStamp,
      };
}
