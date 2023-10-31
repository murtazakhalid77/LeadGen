import 'package:flutter/material.dart';
import 'package:lead_gen/login.dart';
import 'package:lead_gen/signup.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
      routes: {
        'login' :(context) =>LoginPage(),
        'signup' :(context) =>Signup()
      },
  ));
}
