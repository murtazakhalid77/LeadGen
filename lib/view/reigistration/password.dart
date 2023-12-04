import 'package:flutter/material.dart';


class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => PasswordState();
}

class PasswordState extends State<Password> {
   String? _passwordError;
   String? _confirmPasswordError;
   bool _obscureText = true;
  final TextEditingController _passwordController = TextEditingController();
   final TextEditingController _ConfirmpasswordController = TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final loginService = Provider.of<LoginService>(context);


   
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
                    top: MediaQuery.of(context).size.height *
                        0.25, // Adjusted top padding
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
                      top: MediaQuery.of(context).size.height *
                          0.35, // Adjusted top padding
                      left: 35,
                      right: 35,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
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
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
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
                controller: _ConfirmpasswordController,
                obscureText: _obscureText,
                onChanged: (value) {
                  setState(() {
                    _confirmPasswordError = _validateConfirmPassword(value);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
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
    
                              //send otp from java
                              Navigator.pushNamed(context, "/location");
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue, // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius as needed
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal:
                                    30), // Adjust the horizontal padding to make it wider
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
