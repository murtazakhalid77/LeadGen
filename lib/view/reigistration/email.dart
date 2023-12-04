import 'package:flutter/material.dart';

import '../../model/Login.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => EmailState();
}

class EmailState extends State<EmailPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final loginService = Provider.of<LoginService>(context);

    final login = Login(_usernameController.text, _passwordController.text);
    return Form(
      key: _formKey,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.07,
                  top: MediaQuery.of(context).size.height * 0.25,
                ),
                child: const Text(
                  'Enter Your Email',
                  style: TextStyle(
                    fontFamily: "UBUNTU",
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
                            return 'Email is empty';
                          }
                          if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                              .hasMatch(value)) {
                            if (login.email.isNotEmpty) {
                              return 'Enter a valid email';
                            } else {
                              return null; // Return null if email is empty and no validation yet
                            }
                          }
                          return null; // Return null for valid email
                        },
                        onChanged: (val) {
                          setState(() {
                            login.email = val;
                          });
                        },
                        controller: _usernameController,
                        decoration: InputDecoration(
                          focusColor: Colors.blue.shade100,
                          hintText: 'google@mail.com',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                            fontFamily: "UBUNTU",
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(left: 0, right: 115),
                        child: const Text(
                          "We'll send a confirmation code to your mail",
                          style: TextStyle(
                              fontFamily: "UBUNTU",
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {

                            //send otp from java
                            Navigator.pushNamed(context, "/otpEnter");
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal:
                                  30), // Adjust the horizontal padding to make it wider
                        ),
                        child: const Text(
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
