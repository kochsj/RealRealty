import 'package:flutter/material.dart';
import 'package:realtyapp/models/client_model.dart';


Text detailText() {
  return Text('here are some more details');
}

class ScreenArguments {
  final String houseInfo;
  final bloc;

  ScreenArguments(this.houseInfo, this.bloc);
}

class DetailPage extends StatefulWidget {

  @override
  DetailState createState() {
    return DetailState();
  }
}

class DetailState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.houseInfo),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(args.houseInfo, style: TextStyle(fontSize: 28.0)),
              Text('here are some details'),
              Text('sq.ft, bedrooms, bathrooms, etc...'),
            ]
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 70.0),
        child: new Builder(builder: (thisContext) {
          return new FloatingActionButton.extended(onPressed: () {

            Scaffold.of(thisContext).showSnackBar(
                new SnackBar(
                    content: new Text("Added to Favorites!", style: TextStyle(fontSize: 24.0),))
            );
            for (Client c in args.bloc.clients) {
              if (c.firstName == args.houseInfo) {
                return;
              }
            }
            args.bloc.add(Client(firstName: args.houseInfo, lastName: "Rahiche", blocked: 0));
          },
            label: Text('Add to favorites!'),
            icon: Icon(Icons.favorite),
            backgroundColor: Colors.red,);
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
    );
  }
}

