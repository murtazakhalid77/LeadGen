import 'package:flutter/material.dart';
import 'package:lead_gen/services/OtpService.dart';
import 'package:lead_gen/services/UserService.dart';

import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/seller/Seller-Home-Page.dart';
import 'package:lead_gen/view/signupAndLogin/login.dart';
import 'package:lead_gen/view/user-select/categoryRegistration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../enums/UserTypeEnum.dart';

class UserRegistrationSelection extends StatefulWidget {
  final String email;
  const UserRegistrationSelection({Key? key, required this.email})
      : super(key: key);

  @override
  State<UserRegistrationSelection> createState() =>
      _UserRegistrationSelection();
}

class _UserRegistrationSelection extends State<UserRegistrationSelection> {
  final UserService userService = UserService();

  bool _isSellerSelected = false;
  bool _isBuyerSelected = false;
  bool isLoading = false;

  Future<void> setUserType() async {
    try {
      setState(() {
        isLoading = true;
      });
      // Determine the UserType based on _isSellerSelected and _isBuyerSelected
      UserTypeEnum userType;
      if (_isSellerSelected && _isBuyerSelected) {
        userType = UserTypeEnum.BOTH;
      } else if (_isSellerSelected) {
        userType = UserTypeEnum.SELLER;
      } else {
        userType = UserTypeEnum.BUYER;
      }

      var res = await userService.setUserType(widget.email, userType);

      if (res != null) {
        setState(() {
          isLoading = false;
        });
        showCustomToast("User Type Selected: $res");
      } else {
        setState(() {
          isLoading = false;
        });
        showCustomToast("User Type Can't be selected");
      }
    } catch (error) {
      print('Error fetching User: $error');
      setState(() {
        isLoading = false;
      });
      showCustomToast("Error while fetching logged In User");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
                right: 15,
                left: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    image: AssetImage("lib/assets/logo.png"),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Do you want to become\n   a Buyer or a Seller ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSelectionButton(
                        icon: Icons.shopping_cart_rounded,
                        text: 'Want to become a\n Seller!',
                        isSelected: _isSellerSelected,
                        onPressed: () {
                          setState(() {
                            _isSellerSelected = !_isSellerSelected;
                          });
                        },
                      ),
                      _buildSelectionButton(
                        icon: Icons.search,
                        text: 'Want to become a \nbuyer',
                        isSelected: _isBuyerSelected,
                        onPressed: () {
                          setState(() {
                            _isBuyerSelected = !_isBuyerSelected;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[350],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setUserType();

                      // Perform navigation based on conditions
                      if (_isSellerSelected) {
                        setUserType();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryRegistration(
                              email: widget.email,
                            ),
                          ),
                        );
                      } else {
                        setUserType();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(
                              phoneNumber: widget.email,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(18),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
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
      ),
    );
  }

  Widget _buildSelectionButton({
    required IconData icon,
    required String text,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        foregroundColor: Colors.black,
        backgroundColor: isSelected ? Colors.grey[350] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Icon(icon),
              const SizedBox(height: 15),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "UBUNTU",
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          if (isSelected)
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24,
            ),
        ],
      ),
    );
  }
}
