import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/firestore_db.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';
import 'package:realtyapp/shared_widgets/house_list_tile.dart';
import 'package:realtyapp/shared_widgets/loading.dart';

class RecentlyViewedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    return StreamBuilder<List<House>>(
        stream: RecentlyViewedService(uid: user.uid).recentlyViewedHouses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<House> houses = snapshot.data;
            houses.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));

            return Scaffold(
              appBar: AppBar(
                title: Text('Recently Viewed', style: TextStyle(fontSize: 28.0)),
              ),
              body: ListView.builder(
                  itemCount: houses.length,
                  itemBuilder: (context, index){
                    return HouseListTile(house: houses[index]);
                  }),
              bottomNavigationBar: MyCustomNavBar(),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.amber,
              body: Container(
                child: LoadingWidget(),
              ),
              bottomNavigationBar: MyCustomNavBar(),
            );
          }
        }
    );
  }
}

