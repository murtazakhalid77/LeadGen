
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:lead_gen/config/TokenProvider.dart';
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/UserDto.dart';
import 'package:http/http.dart' as http;
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:provider/provider.dart';

class UserService extends ChangeNotifier {
Future<User?> getLoggedInUser(String emailOrNumber) async {
    try {
      final response = await http.get(
         UrlConfig.buildUri('user/getLoggedInUser/${emailOrNumber}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
      
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      User loggedInUser = User.fromJson(responseData);
            
        return loggedInUser;
      }
    // ignore: empty_catches
    }catch(e){
      e.toString();
    }
  
}

 Future<String?> login(String phone, String password) async {
    try {
      final response = await http.post(
         UrlConfig.buildUri("login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'phoneNumber': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        String token = responseData['jwt'].toString();
        print('Login successful');


        await saveToken(token);

        return token;
      } else {
        
        print('Login failed with status code: ${response.statusCode}');
        throw Exception('Login failed. Please check your credentials.');
      }
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to log in. Please try again later.');
    }
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

 