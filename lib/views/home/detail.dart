import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtyapp/models/house.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/firestore_db.dart';
import 'package:realtyapp/shared_widgets/custom_nav_bar.dart';
import 'package:realtyapp/shared_widgets/loading.dart';


Text detailText() {
  return Text('here are some more details');
}

class ScreenArguments {
  final House houseData;
  ScreenArguments(this.houseData);
}

class DetailPage extends StatefulWidget {
  @override
  DetailState createState() {
    return DetailState();
  }
}

class DetailState extends State<DetailPage> {
  bool _isFavorite = false;
  List<House> _houses = [];


  DetailViewFavoriteButton _favoriteButton;

//  void toggleFavorite(args, bool fav) {
//    setState(() {
//      _isFavorite = fav;
//      _favoriteButton = fav
//          ? DetailViewFavoriteButton(args, Colors.transparent, toggleFavorite)
//          : _favoriteButton =
//          DetailViewFavoriteButton(args, Colors.red, toggleFavorite);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute
        .of(context)
        .settings
        .arguments;

    final user = Provider.of<User>(context);


    return StreamBuilder<List<House>>(
        stream: FavoritesDatabaseService(uid: user.uid).favoriteHouses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("snapshot has data: ${snapshot.data}");
            setState(() {
              _houses = snapshot.data;
            });
            return DetailView(_houses);
          } else {
            print("no snapshot data");
            return DetailView(args.houseData);
          }
        }
    );
  }
}
    

class DetailView extends StatelessWidget {
  final houseData;
  DetailView(this.houseData);
  
  bool _isFavorite = false;
  Widget _favoriteButton;

  void toggleFavorite(args, bool fav) {
    print("added/removed from favorites!");

  }
  
  @override
  Widget build(BuildContext context) {
    _favoriteButton = _isFavorite ? DetailViewFavoriteButton(houseData, Colors.red, toggleFavorite) : _favoriteButton = DetailViewFavoriteButton(houseData, Colors.transparent, toggleFavorite);




    return Scaffold(
      appBar: AppBar(
        title: Text(houseData.streetAddress),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _favoriteButton,
              Text(houseData.streetAddress, style: TextStyle(fontSize: 28.0)),
              Text('here are some details'),
              Text('sq.ft, bedrooms, bathrooms, etc...'),
            ]
        ),
      ),
    );
  }
}



class DetailViewFavoriteButton extends StatelessWidget {
  final _houseData;
  final Color _color;
  final Function _callback;

  DetailViewFavoriteButton(this._houseData, this._color, this._callback);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70.0),
      child: new Builder(builder: (thisContext) {
        return new FloatingActionButton.extended(onPressed: () async {
          Scaffold.of(thisContext).showSnackBar(
              new SnackBar(
                  content: new Text("Added to Favorites!", style: TextStyle(fontSize: 24.0),))
          );
        },
          label: Text('Add to favorites!'),
          icon: Icon(Icons.favorite),
          backgroundColor: _color,);
      }),
    );
  }
}










// OLD


//    TODO: check firestore allFavorites
//    for (House house in args.bloc.houses) {
//      if (house.streetAddress == args.houseData.streetAddress) {
//        setState(() {
//          _isFavorite = true;
//        });
//      }
//    }
//
//    _favoriteButton = _isFavorite ? DetailViewFavoriteButton(args, Colors.red, toggleFavorite) : _favoriteButton = DetailViewFavoriteButton(args, Colors.transparent, toggleFavorite);
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(args.houseData.streetAddress),
//      ),
//      body: Center(
//        child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              _favoriteButton,
//              Text(args.houseData.streetAddress, style: TextStyle(fontSize: 28.0)),
//              Text('here are some details'),
//              Text('sq.ft, bedrooms, bathrooms, etc...'),
//            ]
//        ),
//      ),
////      floatingActionButton: DetailViewFavoriteButton(args, _color),
////      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
//    );
//  }
//}

//class DetailViewFavoriteButton extends StatelessWidget {
//  final args;
//  final Color _color;
//  final Function _callback;
//
//  DetailViewFavoriteButton(this.args, this._color, this._callback);
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.only(top: 70.0),
//      child: new Builder(builder: (thisContext) {
//        return new FloatingActionButton.extended(onPressed: () async {
//          for (House c in args.bloc.favoriteHouses) {
//            if (c.streetAddress == args.houseData.streetAddress) {
//              Scaffold.of(thisContext).showSnackBar(
//                  new SnackBar(
//                      content: new Text("Removed from Favorites.", style: TextStyle(fontSize: 24.0),))
//              );
//              await args.bloc.deleteHouse(c.id);
//              _callback(args, false);
//              return;
//            }
//          }
//          Scaffold.of(thisContext).showSnackBar(
//              new SnackBar(
//                  content: new Text("Added to Favorites!", style: TextStyle(fontSize: 24.0),))
//          );
//          await args.bloc.addHouse(args.houseData);
//
//          _callback(args, true);
//        },
//          label: Text('Add to favorites!'),
//          icon: Icon(Icons.favorite),
//          backgroundColor: _color,);
//      }),
//    );
//  }
//}

