import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realtyapp/views/home/profile.dart';
import 'package:realtyapp/views/home/search.dart';
import 'package:realtyapp/views/home/chat.dart';
import 'package:realtyapp/views/home/more.dart';
import 'package:realtyapp/views/home/detail.dart';
import 'favorites.dart';

import 'package:realtyapp/services/firestore_db.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movil Realty',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SearchView(),
      initialRoute: '/',
      routes: {
        '/favorites': (context) => FavoritesPage(),
        '/profile': (context) => ProfilePage(),
        '/chat': (context) => ChatPage(),
        '/more': (context) => MorePage(),
        '/detail': (context) => DetailPage(),
      },
    );
  }
}
