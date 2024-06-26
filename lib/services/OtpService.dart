import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/LocationModel.dart';
import 'package:lead_gen/model/PasswordAndDto.dart';
import 'package:lead_gen/model/Registration.dart';

class OtpService extends ChangeNotifier {


  Future<http.Response> otpSend(String email) async {

// final loginJson = jsonEncode();
    try {
      final response = await http.post(
        UrlConfig.buildUri('sendotp/$email'),

        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      return response;
    } catch (error) {
      // ignore: avoid_print
      print('Error: $error');
      rethrow; // Rethrow the error for the caller to handle
    }
  }
  
  Future<PasswordAndDto?> forgotPassword(String email)async{

    try {
      final response = await http.post(
        UrlConfig.buildUri('user/forgot-password/$email'),

        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if(response.statusCode == 200){
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      PasswordAndDto userType = PasswordAndDto.fromJson(responseData);
            
      return userType;
    }
    } catch (error) {
      // ignore: avoid_print
      print('Error: $error');
      rethrow; // Rethrow the error for the caller to handle
    }
  }

 Future<http.Response> passwordCreation(String password,String email) async {

    try {
      final response = await http.put(
   UrlConfig.buildUri('credentails/$password/$email'),


        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      return response;
    } catch (error) {
      // ignore: avoid_print
      print('Error: $error');
      rethrow; // Rethrow the error for the caller to handle
    }
  }

Future<http.Response> locationCreation(LocationModel location, String number) async {
  try {
    final response = await http.post(
      UrlConfig.buildUri('location/save/$number'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(location.toJson()), 
    );

    return response;
  } catch (error) {
    print('Error: $error');
    rethrow; 
  }
}

Future<http.Response> registerUser(Registration registration) async {
  try {
    final response = await http.put(
      UrlConfig.buildUri('user/save'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registration.toJson()), 
    );

    return response;
  } catch (error) {
    print('Error: $error');
    rethrow; 
  }
}
}