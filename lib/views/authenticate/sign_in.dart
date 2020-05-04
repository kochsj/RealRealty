import 'package:flutter/material.dart';
import 'package:realtyapp/services/auth.dart';



class SignIn extends StatefulWidget {
  final callback;

  SignIn(this.callback);

  @override
  _SignInState createState() => _SignInState(callback);
}

class _SignInState extends State<SignIn> {
  final callback;

  _SignInState(this.callback);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text("Sign In")
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
          child: Text("sign inn"),
          onPressed: () async {
            dynamic result = await _auth.signInAnonymous();
            if (result == null) {
              print("error, not signed in");
            } else {
              print("signed in!");
              print(result);
              callback();
            }
          },
        ),
      ),
    );
  }
}
