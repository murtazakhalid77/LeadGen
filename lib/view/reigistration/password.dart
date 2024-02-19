import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lead_gen/services/OtpService.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/signupAndLogin/signUp.dart';

class Password extends StatefulWidget {
  final String phoneNumber;

  const Password({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<Password> createState() => PasswordState();
}

class PasswordState extends State<Password> {
  OtpService _otpService = new OtpService();

  String? _passwordError;
  String? _confirmPasswordError;
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> passwordCreation(String password, String confirm) async {
    if (password == confirm) {
      try {
        var response =
            await _otpService.passwordCreation(confirm, widget.phoneNumber);

        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SignUpPage(phoneNumber: widget.phoneNumber),
            ),
          );
        } else {
          showCustomToast('The password you entered is not correct');
        }
      } catch (e) {
        // Handle exceptions thrown during OTP verification
        String errorMessage = "Failed to set the password: $e";
        showCustomToast(errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07,
                    top: MediaQuery.of(context).size.height * 0.25,
                  ),
                  child: const Text(
                    'Create password',
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
                      top: MediaQuery.of(context).size.height * 0.35,
                      left: 35,
                      right: 35,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureTextPassword,
                          onChanged: (value) {
                            setState(() {
                              _passwordError = _validatePassword(value);
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureTextPassword =
                                      !_obscureTextPassword;
                                });
                              },
                              icon: Icon(
                                _obscureTextPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            errorText: _passwordError,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureTextConfirmPassword,
                          onChanged: (value) {
                            setState(() {
                              _confirmPasswordError =
                                  _validateConfirmPassword(value);
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureTextConfirmPassword =
                                      !_obscureTextConfirmPassword;
                                });
                              },
                              icon: Icon(
                                _obscureTextConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            errorText: _confirmPasswordError,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              passwordCreation(
                                  _passwordController.text,
                                  _confirmPasswordController.text);
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30),
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
      ),
    );
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is empty';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'(?=.*?[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'(?=.*?[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'(?=.*?[0-9])').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'(?=.*?[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Confirm Password is empty';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}

