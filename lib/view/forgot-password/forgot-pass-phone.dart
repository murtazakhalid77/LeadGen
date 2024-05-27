import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lead_gen/services/OtpService.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/forgot-password/forgot-pass-verify.dart';
import 'package:lead_gen/view/loader.dart';

class ForgotPassPhonePage extends StatefulWidget {
  const ForgotPassPhonePage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPhonePage> createState() => ForgotPassPhoneState();
}

class ForgotPassPhoneState extends State<ForgotPassPhonePage> {
  final OtpService _otpService = OtpService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController= TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> sendOtp() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;

      setState(() {
        isLoading = true; // Show loader when sending OTP
      });

      try {
        var PasswordAndDto= await _otpService.forgotPassword(email);

        if (PasswordAndDto!=null) {
          showCustomToast('OTP sent');

          String otp = PasswordAndDto.otp;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ForgotPassVerify(otp: otp, email: email, password: PasswordAndDto.password,),
            ),
          );
        } else {
          showCustomToast("some error occured");
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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.08,
                right: 35,
                left: 35,
                bottom: MediaQuery.of(context).size.height *
                    0.1, // Adjusted bottom padding
              ),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 150),
                        const Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter an email';
                            }
                            // Basic email format validation
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.lightBlue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.lightBlue),
                            ),
                            hintText: 'example@example.com',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(left: 0, right: 115),
                          child: const Text(
                            "We'll send a confirmation code to your email address",
                            style: TextStyle(
                              fontFamily: "UBUNTU",
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await sendOtp();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                            ),
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Positioned(
              bottom: -100,
              left: 0,
              top: 280,
              right: 0,
              child: Container(
                child: Center(
                  child: LoaderWidget(isLoading: isLoading),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
