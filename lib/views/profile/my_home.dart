import 'package:flutter/material.dart';

class RegisterMyHome extends StatefulWidget {
  @override
  _RegisterMyHomeState createState() => _RegisterMyHomeState();
}

class _RegisterMyHomeState extends State<RegisterMyHome> {
  final _formKey = GlobalKey<FormState>();

  String _homeAddress = '';
  String _city = '';
  String _dropdown = '';
  String _zipcode = '';

  final List<String> _listOfStateAbrv = ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY',
    'LA ', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK',
    'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'];


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<DropdownMenuItem<String>> _stateList = [];

    for (String state in _listOfStateAbrv) {
      _stateList.add(DropdownMenuItem(child: Text(state), value: state,));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your House', style: TextStyle(fontSize: 28.0)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              Column(
                children: <Widget>[
                  Text("Looks like we do not have a house on record for you yet. If you would like to add your home please simply fill out the form below!", textAlign: TextAlign.center,),
                  Text("What is your home address?"),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "street address"
                    ),
                    validator: (value) {
                      if(value.isEmpty) {
                        return "please enter your street address";
                      } else { return null; }
                    },
                    onChanged: (value) {
                      setState(() {
                        _homeAddress = value;
                      });
                    },
                  ),
                  Container(
                    width: width,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "city"
                              ),
                              validator: (value) {
                                if(value.isEmpty) {
                                  return "please enter your home city";
                                } else { return null; }
                              },
                              onChanged: (value) {
                                setState(() {
                                  _city = value;
                                });
                              },
                          ),
                        ),
                        SizedBox(
                            width: 60.0,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  )
                              ),
                              value: _dropdown,
                              items: _stateList,
                              onChanged: (value) {
                                setState(() {
                                  _dropdown = value;
                                });
                              },

                            ),
                          ),
                        SizedBox(
                          width: 80.0,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "zip code"
                            ),
                            validator: (value) {
                              if(value.isEmpty) {
                                return "please enter your home city";
                              } else { return null; }
                            },
                            onChanged: (value) {
                              setState(() {
                                _zipcode = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),



                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
