import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realtyapp/models/agent.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/models/user.dart';

class UserDatabaseService {
  final String uid;
  UserDatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Agent agentFromJson(String str) {
    final jsonData = json.decode(str);
    return Agent.fromMap(jsonData);
  }

  String agentToJson(Agent agent) {
    final dyn = agent.toMap();
    return json.encode(dyn);
  }

  House houseFromJson(String str) {
    final jsonData = json.decode(str);
    return House.fromMap(jsonData);
  }

  String houseToJson(House house) {
    final dyn = house.toMap();
    return json.encode(dyn);
  }

  Future updateUserData(UserData user) async {
    return await userCollection.document(uid).setData({
      "first_name": user.firstName,
      "last_name": user.lastName,
      "phone_number": user.phoneNumber,
      "email": user.email,
      "house": user.house != null ? houseToJson(user.house) : null,
      "agent": user.agent != null ? agentToJson(user.agent) : null,
      "profile_picture": user.profilePicture,
    });
  }

  //user data from document snapshot
  UserData _userFromSnapshot(DocumentSnapshot snapshot) {
//    print("making user data...");
    return UserData(
      uid: uid,
      firstName: snapshot.data['first_name'],
      lastName: snapshot.data['last_name'],
      phoneNumber: snapshot.data['phone_number'],
      email: snapshot.data['email'],
      house: snapshot.data['house'] != null ? houseFromJson(snapshot.data['house']) : null,
      agent: snapshot.data['agent'] != null ? agentFromJson(snapshot.data['agent']) : null,
      profilePicture: snapshot.data['profile_picture'],
    );
  }

  // get individual user doc stream
  Stream<UserData> get userData {
//    print("getting userdata from firestore.... from : $uid");
    return userCollection.document(uid).snapshots()
      .map(_userFromSnapshot);
  }



//  // get user stream
//  Stream<QuerySnapshot> get user {
//    return userCollection.snapshots();
//  }
}

class RecentlyViewedService {
  final String uid;
  RecentlyViewedService({this.uid});

  Future updateUsersRecentlyViewedData(House house) async {
    // collection reference
    final CollectionReference usersRecentlyViewedCollection = Firestore.instance.collection('users').document(uid).collection('recently_viewed');

    return await usersRecentlyViewedCollection.document(house.zpid).setData({
      "zpid": house.zpid,
      "street_address": house.streetAddress,
      "city": house.city,
      "state": house.state,
      "zip_code": house.zipCode,
      "photo_url": house.photoURL,
      "beds": house.beds,
      "baths": house.baths,
      "time_stamp": new DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future deleteUsersRecentlyViewed(House house) async {
    final CollectionReference usersRecentlyViewedCollection = Firestore.instance.collection('users').document(uid).collection('recently_viewed');
    try {
      return await usersRecentlyViewedCollection.document(house.zpid).delete();
    } catch(e) {
      print(e.toString());
    }
  }

  //user data from document snapshot
  List<House>_houseFromSnapshot(QuerySnapshot snapshot) {
    List<House> houses = [];
    for(var house in snapshot.documents) {
      House temp = House(zpid: house.data["zpid"], streetAddress: house.data["street_address"], city: house.data["city"], state: house.data["state"], zipCode: house.data["zip_code"], photoURL: house.data["photo_url"], beds: house.data["beds"], baths: house.data["baths"], timeStamp: house.data["time_stamp"]);
      houses.add(temp);
    }
    return houses;
  }

  // get individual users favorite houses stream
  Stream<List<House>> get recentlyViewedHouses {
    final CollectionReference usersRecentlyViewedCollection = Firestore.instance.collection('users').document(uid).collection('recently_viewed');
    return usersRecentlyViewedCollection.snapshots()
        .map(_houseFromSnapshot);
  }

}




class FavoritesDatabaseService {
  final String uid;
  FavoritesDatabaseService({this.uid});


  Future updateUsersFavoritesData(House house) async {
    // collection reference
    final CollectionReference userFavoritesCollection = Firestore.instance.collection('users').document(uid).collection('favorites');

    return await userFavoritesCollection.document(house.zpid).setData({
      "zpid": house.zpid,
      "street_address": house.streetAddress,
      "city": house.city,
      "state": house.state,
      "zip_code": house.zipCode,
      "photo_url": house.photoURL,
      "beds": house.beds,
      "baths": house.baths,
    });
  }

  Future deleteUsersFavoriteHouse(House house) async {
    final CollectionReference userFavoritesCollection = Firestore.instance.collection('users').document(uid).collection('favorites');
    try {
      return await userFavoritesCollection.document(house.zpid).delete();
    } catch(e) {
      print(e.toString());
    }
  }

  //user data from document snapshot
   List<House>_houseFromSnapshot(QuerySnapshot snapshot) {
      List<House> houses = [];
      for(var house in snapshot.documents) {
        House temp = House(zpid: house.data["zpid"], streetAddress: house.data["street_address"], city: house.data["city"], state: house.data["state"], zipCode: house.data["zip_code"], photoURL: house.data["photo_url"], beds: house.data["beds"], baths: house.data["baths"],);
        houses.add(temp);
      }
      return houses;
  }

  // get individual users favorite houses stream
  Stream<List<House>> get favoriteHouses {
    final CollectionReference userFavoritesCollection = Firestore.instance.collection('users').document(uid).collection('favorites');
    return userFavoritesCollection.snapshots()
      .map(_houseFromSnapshot);
  }


}