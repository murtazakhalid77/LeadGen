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
import 'package:permission_handler/permission_handler.dart';
import '../../firebase/FirebaseApi.dart';
import '../../model/Registration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  final String phoneNumber;

  const SignUpPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final OtpService _otpService = OtpService();
  final _firebaseMessaging = FirebaseMessaging.instance;

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
  final _emailController = TextEditingController();

  Future<Registration> _constructRegistrationObject() async {
    String? token = await getFCMToken();
    return Registration(_firstNameController.text, _lastNameController.text,
        _cnicController.text, _emailController.text, widget.phoneNumber, token);
  }

  Future<void> _registerUser(Registration registrationData) async {
    try {
      var response = await _otpService.registerUser(registrationData);

      if (response.statusCode == 200) {
        showCustomToast('User registered successfully!');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    phoneNumber: '',
                  )),
        );
      } else {
        showCustomToast('User registration failed!');
      }
    } catch (e) {
      print('Error: $e');
      showCustomToast('Error Creating User');
    }
  }

  Future<String?> getFCMToken() async {
    await _firebaseMessaging.requestPermission();
    return await _firebaseMessaging.getToken();
  }

// Future<void> saveFcmToken() async{

// try{
//   String? token=await getFCMToken();
//    var response =
//               await _otpService.locationCreation(location, widget.phoneNumber);

// }

//           if (response.statusCode == 200) {
//             setState(() {
//               isLocationSaved =
//                   true; // Set isLoading to false after the operation completes
//             });
//             showCustomToast('The location is saved');
//           } else {
//             showCustomToast('The location Cannot be saved');
//           }
//         } else {
//           showCustomToast('No location data available');
//         }
//       } catch (e) {
//         print('Error: $e');
//         showCustomToast('User registered successfully!');
//       }
//     }

// }
  // Future<void> _getCurrentLocationAndHitAPI() async {
  //   var permissionStatus = await Permission.location.request();

  //   if (permissionStatus.isGranted) {
  //     try {
  //       Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high,
  //       );

  //       List<Placemark> placemarks = await placemarkFromCoordinates(
  //         position.latitude,
  //         position.longitude,
  //       );

  //       Placemark? currentPlace = placemarks.isNotEmpty ? placemarks[0] : null;

  //       if (currentPlace != null) {
  //         LocationModel location = LocationModel(
  //             locality: currentPlace.locality ?? '',
  //             subLocality: currentPlace.subLocality ?? '',
  //             street: currentPlace.street ?? '',
  //             country: currentPlace.country ?? '',
  //             subAdministrativeArea: currentPlace.subAdministrativeArea ?? '',
  //             administrativeArea: currentPlace.administrativeArea ?? '',
  //             deviceId: await getFCMToken());

  //         var response =
  //             await _otpService.locationCreation(location, widget.phoneNumber);

  //         if (response.statusCode == 200) {
  //           setState(() {
  //             isLocationSaved =
  //                 true; // Set isLoading to false after the operation completes
  //           });
  //           showCustomToast('The location is saved');
  //         } else {
  //           showCustomToast('The location Cannot be saved');
  //         }
  //       } else {
  //         showCustomToast('No location data available');
  //       }
  //     } catch (e) {
  //       print('Error: $e');
  //       showCustomToast('User registered successfully!');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //final login = Registration(_firstNameController.text, _lastNameController.text,_cnicController.text,_emailController.text);

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
                          if (value.isNotEmpty) {
                            return 'Enter a valid email';
                          } else {
                            return null; // Return null if email is empty and no validation yet
                          }
                        }
                        return null; // Return null for valid email
                      },
                      controller: _emailController,
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

                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Registration registrationData =
                              await _constructRegistrationObject();
                          await _registerUser(registrationData);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.lightBlue, // Fixed color for the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Padding(
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
