import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lead_gen/model/LocationModel.dart';
import 'package:lead_gen/services/OtpService.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/signupAndLogin/login.dart';
import 'package:flutter/services.dart';
import 'package:lead_gen/view/user-select/userTypeSelection.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../firebase/FirebaseApi.dart';
import '../../model/Registration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  final String email;
  final String password;

  const SignUpPage({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final OtpService _otpService = OtpService();
  final _firebaseMessaging = FirebaseMessaging.instance;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // _getCurrentLocationAndHitAPI();
    // saveFcmToken();
  }

  final _formKey = GlobalKey<FormState>();

  bool isLocationSaved = false;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cnicController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  Future<Registration> _constructRegistrationObject() async {
    String? token = await getFCMToken();
    String? uid = "";
    return Registration(_firstNameController.text, _lastNameController.text,
        _cnicController.text, _phoneNumberController.text, widget.email, token!, uid);
  }

  Future<void> _registerUser(Registration registrationData) async {
    try {
      print(widget.email);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email:  widget.email, password: widget.password);
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': widget.email,
        'profilePic': ''
      });
      registrationData.uid = userCredential.user!.uid;

      var response = await _otpService.registerUser(registrationData);

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Timer(Duration(seconds: 5), () {
          setState(() {
            isLoading = false;
          });
        });
        showCustomToast('User registered successfully!');

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserRegistrationSelection(
                    email: widget.email,
                  )),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        showCustomToast('User registration failed!');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
      showCustomToast("Error Creating User Or User Cnic Already Exists");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String?> getFCMToken() async {
    await _firebaseMessaging.requestPermission();
    return await _firebaseMessaging.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0.2,
        title: const Text(
          'More information',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06,
                    right: 35,
                    left: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'First Name',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 70),
                        Text('Last Name',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 20,
                            )),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your First Name';
                              }
                              // Check if the input contains only alphabets
                              if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                                return 'Enter only alphabets';
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
                              // Check if the input contains only alphabets
                              if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                                return 'Enter only alphabets';
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
                            value.length != 13) {
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
                          hintText: '4210183671331932',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),

                    const SizedBox(height: 20),

                    //Email Text
                    const Text(
                      'Enter Your phone Number',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 10),

                    //Email Input
                    TextFormField(
                      controller:
                          _phoneNumberController, // Changed from _emailController
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], // Allow only digits
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number is empty';
                        }
                        if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                          return 'Enter a valid phone number with 11 digits';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusColor: Colors.blue.shade50,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.lightBlue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.lightBlue),
                        ),
                        hintText: '03XX1234567',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    //Buttons
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          // If the form is valid, show the loading indicator and proceed with registration
                          setState(() {
                            isLoading = true;
                          });

                          FocusManager.instance.primaryFocus?.unfocus();
                          Registration registrationData = await _constructRegistrationObject();
                          await _registerUser(registrationData);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue, // Fixed color for the button
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

                    // const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
