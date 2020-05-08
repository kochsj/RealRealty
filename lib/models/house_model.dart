import 'dart:convert';
import 'database.dart';

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

  House({
    this.id,
    this.streetAddress,
    this.city,
    this.state,
    this.zipCode,
  });

  factory House.fromMap(Map<String, dynamic> json) => new House(
        id: json["id"],
        streetAddress: json["street_address"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "street_address": streetAddress,
        "city": city,
        "state": state,
        "zip_code": zipCode,
      };
}
