import 'package:flutter/material.dart';
import 'package:realtyapp/views/home/profile.dart';
import 'package:realtyapp/views/home/search.dart';
import 'package:realtyapp/views/home/chat.dart';
import 'package:realtyapp/views/home/more.dart';
import 'package:realtyapp/views/home/detail.dart';
import '../../state.dart';
import 'favorites.dart';

class Home extends StatelessWidget {
//  final bloc = ClientsBloc();
  final bloc;
  Home(this.bloc);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movil Realty',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SearchView(bloc),
      initialRoute: '/',
      routes: {
        '/favorites': (context) => FavoritesPage(bloc),
        '/profile': (context) => ProfilePage(bloc),
        '/chat': (context) => ChatPage(),
        '/more': (context) => MorePage(),
        '/detail': (context) => DetailPage(),
      },
    );
  }
}
