/*
  ENTRY POINT FOR THE APPLICATION
  Checks if a valid session ID is stored on the device.
    if not points to login, else relevant home screen.
*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // local store

import 'package:paani/routes/routes.dart'; // defines the routes, customerHome, and companyHome variables

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paani',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: routes, // defined in routes/routes.dart
      home: prefs.getString('email') == null
          ? index
          : (prefs.getString("accounttype") == 'COMPANY'
              ? companyHome
              : customerHome)));
}

Future<bool> checkloggedin() async {
  //
  SharedPreferences pref = await SharedPreferences.getInstance();
  String email = pref.getString('email') ?? '';
  if (email == '')
    return false;
  else
    return true;
}
