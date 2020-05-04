import 'package:flutter/material.dart';
import 'package:realtyapp/views/authenticate/sign_in.dart';


class Authenticate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthenticateState();
  }
}

class _AuthenticateState extends State<Authenticate> {

  bool _isAuth = false;


  void _updateAuthStatus() {
    setState(() {
      _isAuth = !_isAuth;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isAuth) {
      return Scaffold(
        body: Text("you are logged in"),
      );
    } else {
      return SignIn(_updateAuthStatus);
    }

  }
}



