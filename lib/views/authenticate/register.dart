import 'package:flutter/material.dart';
import 'package:realtyapp/services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  // text field state
  String _email = '';
  String _password = '';
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
                RaisedButton(
                  color: Colors.green,
                  child: Text("Register", style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(_email, _password);
                      if (result == null) {
                        setState(() {
                          _error = "Could not sign in with these credentials";
                        });
                      }
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
