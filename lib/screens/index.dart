/*
  Choose whether to login or signup
  First screen a user sees if they're logged out.
*/

import 'package:flutter/material.dart';

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 130.0),
        child: Column(children: <Widget>[
          Image.asset(
            'assets/logo_transparentbg.png',
            width: 400.0,
            height: 200.0,
            fit: BoxFit.fill,
            key: ValueKey("indexscreen"),
          ),
          customButton('LOG IN', () {
            Navigator.pushNamed(context, '/login');
          }, "loginbutton"),
          customButton('SIGN UP', () {
            Navigator.pushNamed(context, '/signup_as');
          }, "signupbutton"),
        ]),
      ),
    );
  }
}

Widget customButton(String text, Function onPressed, String k) {
  return ButtonTheme(
    key: ValueKey(k),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    buttonColor: Colors.teal,
    minWidth: 150.0,
    child: RaisedButton(
      onPressed: onPressed,
      child: Text(text,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
          )),
    ),
  );
}
