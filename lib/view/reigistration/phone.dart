import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lead_gen/services/OtpService.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/loader.dart';
import 'package:lead_gen/view/reigistration/verify.dart';

class PhonePage extends StatefulWidget {
  final bool isSignUp;

  const PhonePage({Key? key, required this.isSignUp}) : super(key: key);

  @override
  State<PhonePage> createState() => PhoneState();
}

class PhoneState extends State<PhonePage> {
  final OtpService _otpService = OtpService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> sendOtp() async {
    if (_formKey.currentState!.validate()) {
      String phoneNumber = _phoneNumberController.text;

      setState(() {
        isLoading = true; // Show loader when sending OTP
      });

      try {
        var response = await _otpService.otpSend(phoneNumber);

        if (response.statusCode == 200) {
          showCustomToast('OTP sent');

          String otp = response.body;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Verify(otp: otp, phoneNumber: phoneNumber),
            ),
          );
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
                bottom: MediaQuery.of(context).size.height * 0.1, // Adjusted bottom padding
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
                          'Phone Number',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _phoneNumberController,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 11) {
                              return 'Enter a valid Phone Number with 11 digits';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.lightBlue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.lightBlue),
                            ),
                            hintText: '03382644867',
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
                            "We'll send a confirmation code to your Phone Number",
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
