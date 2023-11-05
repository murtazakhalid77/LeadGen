import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/Login.dart';

class LoginService extends ChangeNotifier {


  Future<http.Response> login(Login login) async {

final loginJson = jsonEncode(login.toJson());
    try {
      final response = await http.post(
        UrlConfig.buildUri('user'),

        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: loginJson

      );

      return response;
    } catch (error) {
      // ignore: avoid_print
      print('Error: $error');
      rethrow; // Rethrow the error for the caller to handle
    }
  }
}