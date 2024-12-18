import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lead_gen/services/OtpService.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/reigistration/password.dart';
import 'package:pinput/pinput.dart';

class Verify extends StatefulWidget {
  String otp;
  final String email;

  Verify({Key? key, required this.otp, required this.email}) : super(key: key);

  @override
  State<Verify> createState() => _MyVerifyState();
}
final OtpService _otpService = OtpService();

class _MyVerifyState extends State<Verify> {
  bool isPinFilled = false;
  late String pinEnter;
  bool isLoading = false;

  Future<void> verifyOTP(String phoneNumber) async {
    setState(() {
      isLoading = true; // Set isLoading to false after 3 seconds
    });

    Timer(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false; // Set isLoading to false after 3 seconds
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Password(
              email: widget.email), // Replace '123456' with the actual OTP value
        ),
      );
    });
  }

   Future<void> resendOtp() async {
    String email=widget.email;
    if (widget.email!=null){
      setState(() {
        isLoading = true; // Show loader when sending OTP
      });

      try {
        var response = await _otpService.otpSend(email);

        if (response.statusCode == 200) {
          showCustomToast('OTP sent again');

          String otp = response.body;
         
         widget.otp=otp;
        } else {
          showCustomToast(response.body);
        }
      } catch (e) {
        String errorMessage = "Failed to send OTP: $e";
        showCustomToast(errorMessage);
      } finally {
        setState(() {
          isLoading = false; // Hide loader when OTP sending is complete
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String otp = widget.otp;
    String phoneNumber = widget.email;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(26, 36, 45, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(72, 172, 253, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(59, 133, 202, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return WillPopScope(
      onWillPop: () async {
        // Returning false will prevent the back button from popping the current route
        return false;
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
     /*     appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            ),
            elevation: 0,
          ),*/
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('lib/assets/otpimage.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Phone Verification",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "We need to register your phone without getting started!",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Pinput(
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        // submittedPinTheme: submittedPinTheme,
    
                        showCursor: true,
                        onCompleted: (pin) {
                          setState(() {
                            isPinFilled = pin.length == 6;
                            pinEnter = pin;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isPinFilled ? Colors.blue.shade600 : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: isPinFilled
                              ? () {
                                  if (pinEnter == otp) {
                                    verifyOTP(phoneNumber);
                                    // PIN matches OTP, navigate to '/password'
                                  } else {
                                    // PIN does not match OTP, show a message
                                    Fluttertoast.showToast(
                                      msg: 'The PIN you entered is not correct.',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                    );
                                  }
                                }
                              : null, // Disable button if PIN is not completely filled
                          child: const Text("Verify Phone"),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Edit Phone ?",
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                       resendOtp();                   },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 248, 248, 248), // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                            side: const BorderSide(
                                color: Colors.blue), // Set the border color
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal:
                                  20), // Adjust the horizontal padding to make it wider
                        ),
                        child: const Text(
                          'Resend ?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue, // Set the text color to blue
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.grey.withOpacity(0.6),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          )),
    );
  }
}
