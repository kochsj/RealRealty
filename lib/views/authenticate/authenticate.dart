import 'package:flutter/material.dart';
import 'package:realtyapp/views/authenticate/sign_in.dart';


class Authenticate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthenticateState();
  }
}

class _AuthenticateState extends State<Authenticate> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignIn(),
    );




      return SignIn();



  }
}



