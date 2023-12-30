import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lead_gen/services/UserService.dart';
import 'package:lead_gen/view/buyer/Home.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  late UserService userService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    userService = UserService();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        String? token = await userService.login(
          _emailController.text,
          _passwordController.text,
        );

        if (token != null) {
          // Login successful, navigate to the home page
          Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => MyHomePage(phoneNumber: _emailController.text),
  ),
);
        } else {
          // Login failed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed. Please try again.')),
          );
        }
      } catch (e) {
        // Handle login error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 61, 108, 227),
                Color.fromARGB(255, 61, 200, 255),
              ],
            ),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(0),
                    child: Image.asset(
                      'lib/assets/logo.png',
                      width: 250,
                      height: 250,
                    ),
                  ),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(18.2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.check, color: Colors.grey),
                                labelText: 'PhoneNumber',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 26, 102, 216),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: _togglePasswordVisibility,
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 26, 102, 216),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color(0xff281537),
                                ),
                              ),
                            ),
                            SizedBox(height: 70),
                            _isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: _handleSignIn,
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 61, 78, 227),
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      minimumSize: Size(350, 55),
                                    ),
                                    child: Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 150),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Handle sign-up navigation
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 70),
                          Container(
                            height: 55,
                            width: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 61, 108, 227),
                                  Color.fromARGB(255, 61, 200, 255),
                                ],
                              ),
                            ),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    // Perform login or further actions
                                  }
                                },
                                child: const Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 80),
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
