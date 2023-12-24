import 'package:flutter/material.dart';
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/services/OtpService.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/reigistration/phone.dart';
import 'package:lead_gen/view/signupAndLogin/signUp.dart';
import 'package:lead_gen/view/splashScreen.dart';
import 'package:provider/provider.dart';

void main() {
   runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider<OtpService>(create: (context) => OtpService())
      // ChangeNotifierProvider(create: (context) => Loc()),
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
      title: 'Lead Gen',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: routes,
    );
  }
}

