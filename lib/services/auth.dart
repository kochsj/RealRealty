import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  // create instance of firebase auth to communicate with firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in anonymously
  Future signInAnonymous() async {
    try {
      AuthResult result = await _auth.signInAnonymously(); //returns an "auth result object"

      // the auth result has access to the user object
      FirebaseUser user = result.user;
      return user;

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
}