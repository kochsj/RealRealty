import 'package:flutter/material.dart';
import 'dart:math';

class MortgageCalculatorPage extends StatefulWidget {
  @override
  _MortgageCalculatorPageState createState() => _MortgageCalculatorPageState();
}

class _MortgageCalculatorPageState extends State<MortgageCalculatorPage> {
  final _formKey = GlobalKey<FormState>();

  // user inputs
  String loanAmount = '';
  String annualInterestRate = '';
  String loanDuration = '';

  // calculator output
  String mortgagePayment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0.0,
          title: Text("Mortgage Calculator")
      ),
      body: ListView(
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Total Loan Amount",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please enter a valid loan amount";
                        } else { return null; }
                      },
                      onChanged: (value) {
                        setState(() {
                          loanAmount = value;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Annual Interest Rate",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please enter a valid interest rate";
                        } else { return null; }
                      },
                      onChanged: (value) {
                        setState(() {
                          annualInterestRate = value;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Loan Duration (Years)",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please enter a valid loan duration";
                        } else {
                          try {
                            double.parse(value);
                            return null;
                          } catch(e) {
                            return "please enter a valid loan duration";
                          }

                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          loanDuration = value;
                        });
                      },
                    ),
                    RaisedButton(
                      color: Colors.green,
                      child: Text("Calculate", style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        int p = int.parse(loanAmount);
                        double i = double.parse(annualInterestRate)/1200;
                        double n = double.parse(loanDuration)*12;

                        int payment = (p*(i*pow((1+i), n)) ~/ (pow((1+i), n)-1));

                        setState(() {
                          mortgagePayment = "~ \$${payment.toString()} per month";
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    Text(mortgagePayment),
//                    Text(_error, style: TextStyle(color: Colors.black, fontSize: 28.0),)
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}

