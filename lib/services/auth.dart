import 'package:firebase_auth/firebase_auth.dart';
import 'package:realtyapp/models/user.dart';

class AuthService {

  // create instance of firebase auth to communicate with firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // create user object based on firebase uid
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }


  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(
        (FirebaseUser user) => _userFromFirebaseUser(user)
    );
  }



  // sign in anonymously
  Future signInAnonymous() async {
    try {
      AuthResult result = await _auth.signInAnonymously(); //returns an "auth result object"

      // the auth result has access to the user object
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email/pw
//  Future signInEmail() async {
//    try {
//      AuthResult result = await _auth.signInWithEmailAndPassword(email: null, password: null)
//    } catch(e) {
//      print(e.toString());
//      return null;
//    }
//  }

  //register with email/pw

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