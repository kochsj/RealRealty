import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realtyapp/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

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



  // get user stream
  Stream<QuerySnapshot> get user {
    return userCollection.snapshots();
  }
}