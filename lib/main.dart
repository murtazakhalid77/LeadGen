import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/firebase/FirebaseApi.dart';
import 'package:lead_gen/services/OtpService.dart';
import 'package:lead_gen/view/Chats/all_chats.dart';
import 'package:lead_gen/view/ReviewAndRating/reviews.dart';
import 'package:lead_gen/view/buyer/EditProfile.dart';
import 'package:lead_gen/services/categoryService.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/buyer/myProfile.dart';
import 'package:lead_gen/view/buyer/make_request.dart';
import 'package:lead_gen/view/myAllRequests/my_requests.dart';
import 'package:lead_gen/view/otpPhone.dart';
import 'package:lead_gen/view/reigistration/password.dart';
import 'package:lead_gen/view/reigistration/phone.dart';
import 'package:lead_gen/view/reigistration/verify.dart';
import 'package:lead_gen/view/seller/Seller-All-Request.dart';
import 'package:lead_gen/view/seller/Seller-Home-Page.dart';
import 'package:lead_gen/view/signupAndLogin/login.dart';
import 'package:lead_gen/view/signupAndLogin/signUp.dart';
import 'package:lead_gen/view/splashScreen.dart';
import 'package:lead_gen/view/user-select/selection.dart';
import 'package:lead_gen/view/user-select/userTypeSelection.dart';
import 'package:provider/provider.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await FirebaseApi().initNotifications();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<OtpService>(create: (context) => OtpService()),
        ChangeNotifierProvider<CategoryService>(
            create: (context) => CategoryService())
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
