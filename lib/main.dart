import 'package:flutter/material.dart';
import 'package:lead_gen/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
      routes: {
        'login' :(context) =>LoginPage()
      },
  ));
}
