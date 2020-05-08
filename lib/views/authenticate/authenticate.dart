import 'package:flutter/material.dart';
import 'package:realtyapp/views/authenticate/register.dart';
import 'package:realtyapp/views/authenticate/sign_in.dart';


class Authenticate extends StatefulWidget {
  final bloc;

  Authenticate(this.bloc);

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
      initialRoute: '/',
      routes: {
        '/register': (context) => Register(widget.bloc),
      },
    );




      return SignIn();



  }
}



