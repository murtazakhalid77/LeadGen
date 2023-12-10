import 'package:flutter/material.dart';
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/services/loginService.dart';
import 'package:lead_gen/view/reigistration/email.dart';
import 'package:provider/provider.dart';

void main() {
   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginService>(create: (context) => LoginService())
     //   ChangeNotifierProvider(create: (context) => DataService()),
       // ChangeNotifierProvider(create: (context) => SettingsService()),
      ],
      child: const MyApp(),
    ),
  );  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:  const EmailPage(),
      routes: routes,
    );
  }
}

