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
  bool _isFavorite = false;

  DetailViewFavoriteButton _favoriteButton;

  void toggleFavorite(args, bool fav) {
    setState(() {
      _isFavorite = fav;
      _favoriteButton = fav ? DetailViewFavoriteButton(args, Colors.transparent, toggleFavorite) : _favoriteButton = DetailViewFavoriteButton(args, Colors.red, toggleFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    for (Client house in args.bloc.clients) {
      if (house.firstName == args.houseInfo) {
        setState(() {
          _isFavorite = true;
        });
      }
    }

    _favoriteButton = _isFavorite ? DetailViewFavoriteButton(args, Colors.red, toggleFavorite) : _favoriteButton = DetailViewFavoriteButton(args, Colors.transparent, toggleFavorite);

    return Scaffold(
      appBar: AppBar(
        title: Text(args.houseInfo),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _favoriteButton,
              Text(args.houseInfo, style: TextStyle(fontSize: 28.0)),
              Text('here are some details'),
              Text('sq.ft, bedrooms, bathrooms, etc...'),
            ]
        ),
      ),
//      floatingActionButton: DetailViewFavoriteButton(args, _color),
//      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
    );
  }
}




class DetailViewFavoriteButton extends StatelessWidget {
  final args;
  final Color _color;
  final Function _callback;

  DetailViewFavoriteButton(this.args, this._color, this._callback);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70.0),
      child: new Builder(builder: (thisContext) {
        return new FloatingActionButton.extended(onPressed: () {

          Scaffold.of(thisContext).showSnackBar(
              new SnackBar(
                  content: new Text("Added to Favorites!", style: TextStyle(fontSize: 24.0),))
          );
          for (Client c in args.bloc.clients) {
            if (c.firstName == args.houseInfo) {
              args.bloc.delete(c.id);
              _callback(args, false);
              return;
            }
          }
          args.bloc.add(Client(firstName: args.houseInfo, lastName: "Rahiche", blocked: 0));

          _callback(args, true);
        },
          label: Text('Add to favorites!'),
          icon: Icon(Icons.favorite),
          backgroundColor: _color,);
      }),
    );
  }
}
