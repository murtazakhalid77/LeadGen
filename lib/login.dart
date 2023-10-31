import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lead_gen/signup.dart';
import 'User.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
 

  @override
  State<LoginPage> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
 
    final _formKey = GlobalKey<FormState>();
  User user = User("", "");
  String url = "https://4018-202-47-53-142.ngrok.io/api/user";
 late Uri uri;
 final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Future save() async {
      uri = Uri.parse(url);
    var res = await http.post(uri, // Use the Uri object
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'name': _usernameController.text, 'password': _passwordController.text}));
    print(res.body);
    if (res.body != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Signup(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        user.email = val;
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
                        user.password = val;
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
                     
                          save();
                        
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


