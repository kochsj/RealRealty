import 'package:flutter/material.dart';


class CustomListMenuButton extends StatelessWidget {
  final String buttonText;
  final double width;
  final IconData icon;
  final String routeName;
  final Function callback;
  CustomListMenuButton({this.buttonText, this.width, this.icon, this.routeName, this.callback});

  @override
  Widget build(BuildContext context) {
    Function _callback;
    IconData _icon;

    if (icon == null) {
      _icon = Icons.arrow_forward_ios;
    } else {
      _icon = icon;
    }

    if (callback == null) {
//    callback = () => print("Going to $buttonText....");
      _callback = () => Navigator.pushNamed(context, routeName);
    } else {
      _callback = callback;
    }

    return GestureDetector(
      onTap: () {
        _callback();
      },
      //custom button
      child: Container(
          margin: EdgeInsets.all(10.0),

//          margin: EdgeInsets.only(left: 5.0, right: 5.0),
          width: width,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black)
          ),
          child: Row(
            children: <Widget>[
              Icon(_icon),
              Padding(padding: EdgeInsets.only(left: 12.0),),
              Text(buttonText, style: TextStyle(fontSize: 36),),
            ],
          )
      ),
    );
  }
}


class NavButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final String route;

  NavButton(this.name, this.icon, this.route);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: IconButton(
              icon: Icon(icon),
              onPressed: () {
                Navigator.pushReplacementNamed(context, route);
              }),
          height: 37,
        ),
        Text('$name', style: TextStyle(fontSize: 12),),
      ],
    );
  }
}