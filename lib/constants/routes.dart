

import 'package:flutter/material.dart';
import 'package:lead_gen/view/login.dart';
import 'package:lead_gen/view/otpPhone.dart';
import 'package:lead_gen/view/signup.dart';
import 'package:lead_gen/view/verify.dart';

const String loginRoute = '/login';
const String registerRoute = '/register';
const String otpRegister  = '/otp';
const String otpPinEnter  = '/otpEnter';
const String signnupPage  = '/signup';


final Map<String, WidgetBuilder> routes = {
  loginRoute: (context) =>  LoginPage(),
  registerRoute: (context) => const Signup(),
  otpRegister: (context) => const MyPhone(),
  otpPinEnter: (context) => const Verify()
  
};

class UrlConfig {
   static const String baseUrl = "https://0d26-202-47-53-142.ngrok.io/api";

  static Uri buildUri(String path) {
    return Uri.parse("$baseUrl/$path");
  }
}