import 'dart:convert';
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
  String streetAddress;
  String city;
  String state;
  String zipCode;
  String photoURL;
  String beds;
  String baths;

  House({
    this.id,
    this.streetAddress,
    this.city,
    this.state,
    this.zipCode,
    this.photoURL,
    this.beds,
    this.baths,
  });

  factory House.fromMap(Map<String, dynamic> json) => new House(
        id: json["id"],
        streetAddress: json["street_address"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
        photoURL: json["photo_url"],
        beds: json["beds"],
        baths: json["baths"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "street_address": streetAddress,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "photo_url": photoURL,
        "beds": beds,
        "baths": baths
      };
}
