

import 'package:flutter/material.dart';
import 'package:lead_gen/view/buyer/buyer-home.dart';
import 'package:lead_gen/view/reigistration/email.dart';
import 'package:lead_gen/view/otpPhone.dart';
import 'package:lead_gen/view/reigistration/getlocation.dart';
import 'package:lead_gen/view/reigistration/password.dart';

import 'package:lead_gen/view/reigistration/verify.dart';
import 'package:lead_gen/view/seller/seller-home.dart';

const String email = '/email';
const String otpRegister  = '/otp';
const String otpPinEnter  = '/otpEnter';
const String password  = '/password';
const String location  = '/location';
const String buyer_home  = '/buyer-home';
const String seller_home  = '/seller-home';


final Map<String, WidgetBuilder> routes = {
  email: (context) =>  const EmailPage(),
  password :(context) => const Password(),
  otpRegister: (context) => const MyPhone(),  
  otpPinEnter: (context) => const Verify(),
  location: (context) => const Location(),
  buyer_home: (context) => const BuyerHomePage(),
  seller_home: (context) => const SellerHomePage(),
  
};

class UrlConfig {
   static const String baseUrl = "https://0d26-202-47-53-142.ngrok.io/api";

  static Uri buildUri(String path) {
    return Uri.parse("$baseUrl/$path");
  }
}