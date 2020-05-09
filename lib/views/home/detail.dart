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
  final House houseBeingViewed;
  ScreenArguments(this.houseBeingViewed);
}

class DetailPage extends StatelessWidget {
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
            List<House> _houses = snapshot.data;
            return DetailView(user, args.houseBeingViewed, _houses);
          } else {
            return DetailView(user, args.houseBeingViewed, []);
          }
        }
    );
  }
}
    
class DetailView extends StatefulWidget {
  final houseBeingViewed;
  final listOfFavoriteHouses;
  final user;
  DetailView(this.user, this.houseBeingViewed, this.listOfFavoriteHouses);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {

  bool _isFavorite = false;
  Widget _favoriteButton;

  void toggleFavorite(bool isFavorite) async {
    if(isFavorite){
      await FavoritesDatabaseService(uid: widget.user.uid).deleteUsersFavoriteHouse(widget.houseBeingViewed);
      setState(() {
        _isFavorite = false;
      });
    } else {
      await FavoritesDatabaseService(uid: widget.user.uid).updateUsersFavoritesData(widget.houseBeingViewed);
    }

    print("added/removed from favorites!");
  }

  @override
  Widget build(BuildContext context) {
    // find out if the selected house is a favorite already
    for(House houseFromDB in widget.listOfFavoriteHouses) {
      if(houseFromDB.zpid == widget.houseBeingViewed.zpid) {
        _isFavorite = true;
      }
    }

    _favoriteButton = _isFavorite ? DetailViewFavoriteButton(_isFavorite, Colors.red, toggleFavorite) : _favoriteButton = DetailViewFavoriteButton(_isFavorite, Colors.transparent, toggleFavorite);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.houseBeingViewed.streetAddress),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _favoriteButton,
              Text(widget.houseBeingViewed.streetAddress, style: TextStyle(fontSize: 28.0)),
              Text('here are some details'),
              Text('sq.ft, bedrooms, bathrooms, etc...'),
            ]
        ),
      ),
    );
  }
}



class DetailViewFavoriteButton extends StatelessWidget {
  final bool _isFavorite;
  final Color _color;
  final Function _callback;

  DetailViewFavoriteButton(this._isFavorite, this._color, this._callback);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 70.0),
      child: new Builder(builder: (thisContext) {
        return new FloatingActionButton.extended(onPressed: () async {
          if(_isFavorite) {
            Scaffold.of(thisContext).showSnackBar(
                new SnackBar(
                    content: new Text("Removed from Favorites", style: TextStyle(fontSize: 24.0),))
            );
          } else {
            Scaffold.of(thisContext).showSnackBar(
                new SnackBar(
                    content: new Text("Added to Favorites!", style: TextStyle(fontSize: 24.0),))
            );
          }
          _callback(_isFavorite);
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

