import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lead_gen/services/OtpService.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/reigistration/verify.dart';


class PhonePage extends StatefulWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  State<PhonePage> createState() => PhoneState();
}


class PhoneState extends State<PhonePage> {
  bool isLoading = false;
    final OtpService _otpService = OtpService(); 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();

   @override
  void dispose() {
    // Dispose of the controller when the State object is removed from the tree
    _phoneNumberController.dispose();
    super.dispose();
  }
  Future<void> sendOtp() async {
    if (_formKey.currentState!.validate()) {
      String phoneNumber = _phoneNumberController.text;
 setState(() {
      isLoading = true; // Show loader when OTP sending begins
    });

      try {
        var response = await _otpService.otpSend(phoneNumber);

        if (response.statusCode == 200) {
          // Successful OTP send
          showCustomToast('OTP sent');

          String otp = response.body; // Extract the OTP from the response

      Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Verify(otp: otp,phoneNumber:phoneNumber), // Replace '123456' with the actual OTP value
    ),
  );
        } else {
          
          showCustomToast(response.body);
        }
      } catch (e) {
        
        String errorMessage = "Failed to send OTP: $e";
        showCustomToast(errorMessage);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SingleChildScrollView(
        // adds scrolling in page
        child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.08,
              right: 35,
              left: 35),

          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
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
                        hintText: '+92 3373927254',
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
        await sendOtp(); // Call sendOtp method
        
      }
    },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Background color
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
    );
  }
}
