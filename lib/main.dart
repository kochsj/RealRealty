import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/auth.dart';
import 'package:realtyapp/views/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: Wrapper(),
    );




//    return StreamProvider<User>.value(
//      value: AuthService().user,
//      child: MaterialApp(
//        home: Wrapper(),
//      ),
//    );
  }
}