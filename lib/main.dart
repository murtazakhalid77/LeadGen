import 'package:flutter/material.dart';
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/services/loginService.dart';
import 'package:lead_gen/view/reigistration/email.dart';
import 'package:lead_gen/view/signup.dart';
import 'package:provider/provider.dart';

void main() {
   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginService>(create: (context) => LoginService())
     //   ChangeNotifierProvider(create: (context) => DataService()),
       // ChangeNotifierProvider(create: (context) => SettingsService()),
      ],
      child: MyApp(),
    ),
  );
   
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:  EmailPage(),
      routes: routes,
    );
  }
}

