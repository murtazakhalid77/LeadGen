

import 'package:flutter/material.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';

import 'package:lead_gen/view/buyer/all_categories.dart';
import 'package:lead_gen/view/buyer/make_request.dart';
import 'package:lead_gen/view/buyer/vehicles.dart';
import 'package:lead_gen/view/myAllRequests/my_requests.dart';
import 'package:lead_gen/view/reigistration/phone.dart';
import 'package:lead_gen/view/otpPhone.dart';
import 'package:lead_gen/view/reigistration/getlocation.dart';
import 'package:lead_gen/view/reigistration/password.dart';

import 'package:lead_gen/view/reigistration/verify.dart';
import 'package:lead_gen/view/seller/Seller-All-Request.dart';
import 'package:lead_gen/view/seller/Seller-Home-Page.dart';
import 'package:lead_gen/view/signupAndLogin/login.dart';
import 'package:lead_gen/view/signupAndLogin/signUp.dart';
import 'package:lead_gen/view/user-select/selection.dart';

const String phone = '/phone';
const String otpRegister  = '/otp';
const String otpPinEnter  = '/otpEnter';
const String password  = '/password';
const String location  = '/location';
const String buyer_home  = '/buyer-home';
const String seller_home  = '/seller-home';
const String seller_request  = '/seller-request';
const String buyer_makeRequest = '/buyer_makeRequest';
const String buyer_allCategories = '/buyer_allCategories';
const String buyer_vehicle = '/buyer_vehicle';
const String sign_up = '/signup';
const String log_in = '/login';
const String user_Selection = '/user_selection';
const String my_requests = '/my_requests';


final Map<String, WidgetBuilder> routes = {
  phone: (context) =>  const PhonePage(),
  // password :(context) => const Password(),
  otpRegister: (context) => const MyPhone(),  
  // otpPinEnter: (context) => const Verify(phoneNumber: '',),
  location: (context) => const Location(),
  
  
  buyer_allCategories:(context) => const AllCategoriesPage(),
  buyer_vehicle:(context) => const VehiclesPage(),
  seller_home: (context) => const SellerHomePage(),

  seller_request: (context) => const AllRequest(),
  // sign_up:(context) => const SignUpPage(),
  log_in:(context) => const LoginScreen(phoneNumber: '',),
  user_Selection:(context) => const SelectionPage(phoneNumber: '',),

};

class UrlConfig {
static const String baseUrl = "http://192.168.10.9:8080/api";


  static Uri buildUri(String path) {
    return Uri.parse("$baseUrl/$path");
  }
}