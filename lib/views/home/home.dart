import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realtyapp/views/home/profile.dart';
import 'package:realtyapp/views/home/search.dart';
import 'package:realtyapp/views/home/chat.dart';
import 'package:realtyapp/views/home/more.dart';
import 'package:realtyapp/views/home/detail.dart';
import 'package:realtyapp/views/more/contact_us.dart';
import 'package:realtyapp/views/more/mortgage_calculator.dart';
import 'package:realtyapp/views/more/our_team.dart';
import 'package:realtyapp/views/more/recently_viewed.dart';
import 'package:realtyapp/views/profile/my_agent.dart';
import 'package:realtyapp/views/profile/my_documents.dart';
import 'package:realtyapp/views/profile/my_home.dart';
import 'package:realtyapp/views/profile/profile_preferences.dart';
import 'package:realtyapp/views/more/more_settings.dart';
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
        // Primary NavBar Routes
        '/favorites': (context) => FavoritesPage(),
        '/profile': (context) => ProfilePage(),
        '/chat': (context) => ChatPage(),
        '/more': (context) => MorePage(),
        '/detail': (context) => DetailPage(),

        // Secondary Profile Routes
        '/profile/agent': (context) => MyAgentPage(),
        '/profile/documents': (context) => MyDocumentsPage(),
        '/profile/preferences': (context) => ProfilePreferencesPage(),
        '/profile/myhome': (context) => RegisterMyHome(),

        // Secondary More Page Routes
        '/more/contactus': (context) => ContactUsPage(),
        '/more/calculator': (context) => MortgageCalculatorPage(),
        '/more/ourteam': (context) => OurTeamPage(),
        '/more/recent': (context) => RecentlyViewedPage(),
        '/more/settings': (context) => MoreSettingsPage(),


      },
    );
  }
}
