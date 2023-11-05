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
    final loginService = Provider.of<LoginService>(context);

  final login = Login(_usernameController.text,_passwordController.text);

  Future<void> handleLogin() async {
      showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Change the color here
        ),
      );
    },
  );
      final response = await loginService.login(login);

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/otp');
        print('Login successful: ${response.body}');
      } else {
        // Failed login
        // Handle the login failure
        print('Login failed with status: ${response.statusCode}');
      }
    }


    return Form(
      child: Container(
        width: double.infinity, // Set the width to occupy the entire screen
        height: double.infinity, // Set the height to occupy the entire screen
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 80, top: 170),
                child: const Text(
                  'Welcome\nBack',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 33),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5,
                      left: 35,
                      right: 35),
                  child: Column(children: [
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
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      onChanged: (val) {
                        login.password = val;
                      },
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password is Empty';
                        }
                        return null;
                      },
                    
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xff4c505b),
                          child: IconButton(
                               onPressed: () {
                     
                          handleLogin();
                        
                      },
                              icon: const Icon(Icons.arrow_forward)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'signup');
                            },
                            child: const Text(
                              "Sing Up",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


