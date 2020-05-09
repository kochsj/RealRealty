import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realtyapp/models/agent.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/models/user.dart';

class UserDatabaseService {
  final String uid;
  UserDatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(User user) async {
    return await userCollection.document(uid).setData({
      "first_name": user.firstName,
      "last_name": user.lastName,
      "phone_number": user.phoneNumber,
      "email": user.email,
      "house": user.house,
      "agent": user.agent,
      "profile_picture": user.profilePicture,
    });
  }

  //user data from document snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
//    print("making user data...");
    return UserData(
      uid: uid,
      firstName: snapshot.data['first_name'],
      lastName: snapshot.data['last_name'],
      phoneNumber: snapshot.data['phone_number'],
      email: snapshot.data['email'],
      house: snapshot.data['house'],
      agent: snapshot.data['agent'],
      profilePicture: snapshot.data['profile_picture'],
    );
  }

  // get individual user doc stream
  Stream<UserData> get userData {
    print("getting userdata from firestore.... from : $uid");
    return userCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }



//  // get user stream
//  Stream<QuerySnapshot> get user {
//    return userCollection.snapshots();
//  }
}


//class AgentDatabaseService {
//  // collection reference
//  final CollectionReference userCollection = Firestore.instance.collection('agents');
//
//  Future updateAgentData(Agent agent) async {
//    return await userCollection.document(uid).setData({
//      "first_name": user.firstName,
//      "last_name": user.lastName,
//      "phone_number": user.phoneNumber,
//      "email": user.email,
//      "house": user.house,
//      "agent": user.agent,
//      "profile_picture": user.profilePicture,
//    });
//  }
//}

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

  //user data from document snapshot
   List<House>_houseFromSnapshot(QuerySnapshot snapshot) {
//    print("making user data...");
    List<House> houses = [];

    for(var house in snapshot.documents) {
      House temp = House(zpid: house.data["zpid"], streetAddress: house.data["street_address"], city: house.data["city"], state: house.data["state"], zipCode: house.data["zip_code"], photoURL: house.data["photo_url"], beds: house.data["beds"], baths: house.data["baths"],);
      houses.add(temp);
    }

    return houses;
  }

  // get user stream
  Stream<List<House>> get favoriteHouses {
    final CollectionReference userFavoritesCollection = Firestore.instance.collection('users').document(uid).collection('favorites');
    return userFavoritesCollection.snapshots()
      .map(_houseFromSnapshot);
  }

//  // get individual user doc stream
//  Stream<House> get houseData {
//    print("getting userdata from firestore.... from : $uid");
//    return userCollection.document(uid).snapshots()
//        .map(_userDataFromSnapshot);
//  }
}