import 'package:flutter/material.dart';
import 'package:realtyapp/models/user.dart';
import 'package:realtyapp/services/auth.dart';

class Register extends StatefulWidget {
  final bloc;
  Register(this.bloc);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  // text field state
  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0.0,
          title: Text("Sign Up to Realty"),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Sign In", style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "email",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "please enter a valid email";
                    } else { return null; }
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "password",
                  ),
                  validator: (value) => value.length < 6 ? "password required - more than 6 characters" : null,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "first name",
                  ),
                  validator: (value) => value.length < 1 ? "first name required" : null,
                  onChanged: (value) {
                    setState(() {
                      _firstName = value;
                    });
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "last name",
                  ),
                  validator: (value) => value.length < 1 ? "last name required" : null,
                  onChanged: (value) {
                    setState(() {
                      _lastName = value;
                    });
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "phone number",
                  ),
                  validator: (value) => value.length < 10 ? "valid phone number required" : null,
                  onChanged: (value) {
                    setState(() {
                      _phoneNumber = value;
                    });
                  },
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  color: Colors.green,
                  child: Text("Register", style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(_email, _password, _firstName, _lastName, _phoneNumber);
                      if (result == null) {
                        setState(() {
                          _error = "Could not sign in with these credentials";
                        });
                      }
                      // TODO: add user to db
                      widget.bloc.addUser(result);
                      User _user = await widget.bloc.getUser(result.id);

                      print(_user);
                    }
                  },
                ),
                SizedBox(height: 20,),
                Text(_error, style: TextStyle(color: Colors.black, fontSize: 28.0),)

              ],
            ),
          )

      ),
    );
  }
}
