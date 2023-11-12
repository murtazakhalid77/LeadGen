import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/services/loginService.dart';
import 'package:lead_gen/view/signup.dart';
import '../model/Login.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final loginService = Provider.of<LoginService>(context);

    final login = Login(_usernameController.text, _passwordController.text);

    Future<void> handleLogin() async {
      //     showDialog(
      //   context: context,
      //   builder: (context) {
      //     return Center(
      //       child: CircularProgressIndicator(
      //         valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Change the color here
      //       ),
      //     );
      //   },
      // );
      //     final response = await loginService.login(login);

      //     if (response.statusCode == 200) {
      //       Navigator.pushNamed(context, '/otp');
      //       print('Login successful: ${response.body}');
      //     } else {
      //       // Failed login
      //       // Handle the login failure
      //       print('Login failed with status: ${response.statusCode}');
      //     }
    }

    return Form(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.07,
                  top: MediaQuery.of(context).size.height *
                      0.25, // Adjusted top padding
                ),
                child: const Text(
                  'Enter Your Email',
                  style: TextStyle(
                    fontFamily: 'UBUNTU',
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 33,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height *
                        0.35, // Adjusted top padding
                    left: 35,
                    right: 35,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'email is Empty';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          login.email = val;
                        },
                        controller: _usernameController,
                        decoration: InputDecoration(
                          focusColor: Colors.blue.shade100,
                          hintText: 'google@mail.com',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'UBUNTU',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 0, right: 100),
                        child: const Text(
                          "We'll send a confirmation code to your mail",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal),
                        ),
                      ),
                        SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          // Your button press logic
                        },
                        style: TextButton.styleFrom(
                         
                          backgroundColor: Colors.blue, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                          ),
                           padding: EdgeInsets.symmetric(horizontal: 30), // Adjust the horizontal padding to make it wider
                        ),
                      
                        child:const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
