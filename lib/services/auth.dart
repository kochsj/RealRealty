import 'package:firebase_auth/firebase_auth.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/firestore_db.dart';

class AuthService {

  // create instance of firebase auth to communicate with firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // create user object based on firebase uid
  User _userFromFirebaseUser(FirebaseUser user, [String firstName, String lastName, String phoneNumber, String email]) {
    return user != null ? User(uid: user.uid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email) : null;
  }

  UserData _userDataFromFirebaseUser(FirebaseUser user, [String firstName, String lastName, String phoneNumber, String email]) {
    return user != null ? UserData(uid: user.uid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email) : null;
  }


  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(
        (FirebaseUser user) => _userFromFirebaseUser(user)
    );
  }



  // sign in anonymously
//  Future signInAnonymous() async {
//    try {
//      AuthResult result = await _auth.signInAnonymously(); //returns an "auth result object"
//
//      // the auth result has access to the user object
//      FirebaseUser user = result.user;
//      return _userFromFirebaseUser(user);
//
//    } catch(e) {
//      print(e.toString());
//      return null;
//    }
//  }

  //sign in with email/pw
  Future<User> signInEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser _user = result.user;
//      UserDatabaseService(uid: _user.uid);
      return _userFromFirebaseUser(_user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //register with email/pw
  Future registerWithEmailAndPassword(String email, String password, String firstName, String lastName, String phoneNumber) async {
    try {
      AuthResult _result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser _firebaseUser = _result.user;
      User _user = _userFromFirebaseUser(_firebaseUser, firstName, lastName, phoneNumber, email);
      UserData _userData = _userDataFromFirebaseUser(_firebaseUser, firstName, lastName, phoneNumber, email);
      // create document in firestore
      await UserDatabaseService(uid: _user.uid).updateUserData(_userData);

      return _user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // method to sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}