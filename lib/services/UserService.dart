
import 'dart:convert';

import 'package:lead_gen/enums/UserTypeEnum.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:lead_gen/config/TokenProvider.dart';
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/UserDto.dart';
import 'package:http/http.dart' as http;
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:provider/provider.dart';

import '../model/UserDetails.dart';

class UserService extends ChangeNotifier {

  Future setCategory(String email, List<String> selectedCategories) async {
  try{
    final response = await http.put(
      UrlConfig.buildUri('user/${email}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(selectedCategories)
    );

print(response.statusCode);
    return response.statusCode;

  }catch(e){
      e.toString();
    }
}

  Future editUserProfile(String name, String updatedPhone, String email, String userPhone) async {
    try{
      final response = await http.put(
      UrlConfig.buildUri('user/updateProfile/${name}/${updatedPhone}/${email}/${userPhone}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
      // final response = await http.put(
      //   UrlConfig.buildUri('user/updatePassword/${updatedPhone}/${password}'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      return response;

    }catch(e){
      e.toString();
    }
  }

  Future updatePassword(String email, String password) async {
  try{
    final response = await http.put(
      UrlConfig.buildUri('user/updatePassword/${email}/${password}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;

  }catch(e){
      e.toString();
    }
}

Future<UserType?> getUserType(String email) async {
  try{
    final response = await http.get(
      UrlConfig.buildUri('user/getUserType/${email}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if(response.statusCode == 200){
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      UserType userType = UserType.fromJson(responseData);
            
      return userType;
    }

  }catch(e){
      e.toString();
    }
}

Future<User?> getLoggedInUser(String? email)async {
    try {
      final response = await http.get(
         UrlConfig.buildUri('user/getLoggedInUser/${email}'),
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

 Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
         UrlConfig.buildUri("login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
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

  Future<bool> setUserType(String email, UserTypeEnum userTypeEnum) async {
  try {
    // Convert enum value to string
    String userTypeString;
    switch (userTypeEnum) {
      case UserTypeEnum.BUYER:
        userTypeString = 'buyer';
        break;
      case UserTypeEnum.SELLER:
        userTypeString = 'seller';
        break;
      case UserTypeEnum.BOTH:
        userTypeString = 'both';
        break;
    }


    final response = await http.post(
      UrlConfig.buildUri('user/setUserType/$email/$userTypeString'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
    
      return true;
    } else {
      return false;
     
    }
  } catch (e) {
    // Handle exceptions
 showCustomToast("the user type cant be set up");
   throw Exception('Failed to set user type');
  }
}
}

 