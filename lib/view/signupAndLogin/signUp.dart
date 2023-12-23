import 'package:flutter/material.dart';
import 'package:lead_gen/view/signupAndLogin/login.dart';
import 'package:flutter/services.dart';

import '../../model/Login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cnicController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final login = Login(_usernameController.text, _passwordController.text);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0.2,
        title: const Text(
          'Registration',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            // Unfocus the current focus node before popping the screen
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pop(); // Add navigation functionality here
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              // adds scrolling in page
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06,
                    right: 35,
                    left: 35),

                //Text First Name and Last Name
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Name and Last Name in a Row
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // First Name Text
                        Text(
                          'First Name',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 20,
                          ),
                        ),

                        // Spacer between First Name and Last Name Text
                        SizedBox(width: 70),

                        // Last Name Text
                        Text(
                          'Last Name',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Row for First Name Input
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your First Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.lightBlue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.lightBlue,
                                ),
                              ),
                              hintText: 'First Name',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your Last Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.lightBlue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.lightBlue,
                                ),
                              ),
                              hintText: 'Last Name',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    //Text CNIC
                    const Text(
                      'CNIC',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 10),

                    //CNIC input
                    TextFormField(
                      controller: _cnicController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], // Allow only digits
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 14) {
                          return 'Enter a valid CNIC with 14 digits';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.lightBlue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.lightBlue)),
                          hintText: '42301-835745678-2',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),

                    const SizedBox(height: 20),

                   //Email Text
                    const Text(
                      'Enter Your Email',
                      style: TextStyle(
                      //  fontFamily: "UBUNTU",
                        color: Colors.blue,
                      //  fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 10),

                    //Email Input
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
                          fontSize: 18,
                      //    fontFamily: "UBUNTU",
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // register Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Validation passed, continue with sign-up
                          // Unfocus the current focus node before popping the screen
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LogInPage(), // goes to all categories page
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(18),
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    //Already have an account? login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            // Navigate to SignUpPage when "Sign Up" is clicked
                            Navigator.of(context).pushNamed('logInPage');
                          },
                          child: const Text(
                            'LogIn',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
