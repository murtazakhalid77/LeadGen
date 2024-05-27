import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lead_gen/services/OtpService.dart';
import 'package:lead_gen/services/UserService.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/signupAndLogin/login.dart';
import 'package:lead_gen/view/signupAndLogin/signUp.dart';

class ForgotPassword extends StatefulWidget {
  final String email;
  final String password;

  const ForgotPassword({Key? key, required this.email,required this.password}) : super(key: key);

  @override
  State<ForgotPassword> createState() => PasswordState();
}

class PasswordState extends State<ForgotPassword> {
  UserService _userService = new UserService();

  String? _passwordError;
  String? _confirmPasswordError;
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
    final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> passwordCreation(String newPassword, String confirm) async {
  if (newPassword == confirm) {
    try {

      String a=widget.email;
      String b= widget.password;
      // Sign in the user with email and old password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: a,password: b,);

print(widget.password);
      User? user = userCredential.user;

      if (user != null) {
        // Update the user's password
        await user.updatePassword(confirm);
        await user.reload();

        // Assuming _userService.updatePassword is an API call to update password in your backend
        var response = await _userService.updatePassword( widget.email,confirm);

        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(phoneNumber: widget.email),
            ),
          );
        } else {
          showCustomToast('Failed to update the password in backend');
        }
      } else {
        showCustomToast('Failed to sign in the user');
      }
    } catch (e) {
      // Handle exceptions thrown during sign-in or password update
      String errorMessage = "Failed to set the password: $e";
      showCustomToast(errorMessage);
    }
  } else {
    showCustomToast('Passwords do not match');
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
                    'Update password',
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
                                  _obscureTextPassword = !_obscureTextPassword;
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
                              passwordCreation(_passwordController.text,
                                  _confirmPasswordController.text);
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
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
