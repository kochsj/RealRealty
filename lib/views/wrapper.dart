import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/views/authenticate/authenticate.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/views/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<User>(context);
    print(_user);

    // return home or auth widget

    if (_user == null) {
      return Authenticate();
    } else {
      return Home();
    }

  }
}
