import 'dart:async';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lead_gen/enums/UserTypeEnum.dart';
import 'package:lead_gen/model/UserDetails.dart';
import 'package:lead_gen/services/UserService.dart';

import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/loader.dart';
import 'package:lead_gen/view/reigistration/phone.dart';
import 'package:lead_gen/view/seller/Seller-Home-Page.dart';
import 'package:lead_gen/view/user-select/categoryRegistration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectionPage extends StatefulWidget {
  final String email;
  const SelectionPage({Key? key, required this.email}) : super(key: key);

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  late String email;
  late UserService userService;
  late UserType userType;
  late bool option;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    userService = UserService();
    userType = UserType();
    email = widget.email;
    fetchData();
  }

  Future<void> setUserType(UserTypeEnum userType) async {
    try {
      await userService.setUserType(widget.email, userType);
    } catch (error) {
      print('Error fetching User: $error');
      showCustomToast("Error while fetching logged In User");
    }
  }

  Future<void> moveToSelectedPage(bool option, bool condition) async {
    setState(() {
      isLoading = true;
    });

    
      Timer(Duration(seconds: 3), () {
        setState(() {
        isLoading = false; // Set isLoading to false after 3 seconds
      });
      if (condition) {
        showCustomToast('Welcome To Seller Home Page');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    option: option,
                    email: email,
                  )),
        );
      } else {
        showCustomToast('Welcome To Buyer Home Page');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    option: option,
                    email: email,
                  )),
        );
      }
    });
  }

  Future<void> changePage(bool option, String phone, bool condition) async {
    setState(() {
      isLoading = true;
    });

    Timer(Duration(seconds: 3), () {
       setState(() {
        isLoading = false; // Set isLoading to false after 3 seconds
      });
      if (condition) {
        setUserType(UserTypeEnum.SELLER);
        Navigator.pop(context); // Hide the loader
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CategoryRegistration(
                email: email,
              );
            },
          ),
        );
      } else {
        setUserType(UserTypeEnum.BUYER);
        showCustomToast('Successfully registered as a Buyer');
        Navigator.pop(context); // Hide the loader
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MyHomePage(
                option: option,
                email: email,
              );
            },
          ),
        );
      }
    });
  }

  Future<void> fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');

      if (email != null) {
        UserType? userType = await userService.getUserType(email);

        setState(() {
          this.userType = userType!;
        });
      } else {
        // Handle the case where phone number is not available in shared preferences
        print('Phone number not found in shared preferences');
      }
    } catch (error) {
      print('Error fetching User Type: $error');
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
                top: MediaQuery.of(context).size.height * 0.04,
                right: 15,
                left: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    image: AssetImage("lib/assets/logo.png"),
                  ),
                  const SizedBox(height: 5),
                  buildElevatedButtons(
                      context, widget.email, this.userType.user_Type),

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
          // ),
        ],
      ),
    );
  }

  Widget buildElevatedButtons(BuildContext context, String email, String type) {
    if (type == "BOTH") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildElevatedButton(email, context, true, true),
          buildElevatedButton(email, context, false, false),
        ],
      );
    } else {
      return Center(
        // Wrap the Column with Center widget
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (type == "SELLER") ...[
              buildElevatedButton(email, context, true, true),
              buildTextButton(email, context, false, false),
            ],
            if (type == "BUYER") ...[
              buildElevatedButton(email, context, false, false),
              buildTextButton(email, context, true, true),
            ],
          ],
        ),
      );
    }
  }

  Widget buildTextButton(
      String phoneNumber, BuildContext context, bool condition, bool option) {
    return TextButton(
      onPressed: () {
        changePage(option, phoneNumber, condition);
      },
      child: Text(
        condition ? "Want to become a seller?" : "Want to become a Buyer?",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildElevatedButton(
      String email, BuildContext context, bool condition, bool option) {
    return ElevatedButton(
      onPressed: () {
        moveToSelectedPage(option, condition);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            vertical: 20, horizontal: 30), // Adjust padding as needed
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey[350],
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15.0), // Adjust the radius as needed
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          Icon(condition ? Icons.shopping_cart_rounded : Icons.search),
          const SizedBox(height: 15),
          Text(
            condition ? "Want to sell \nsomething" : "Looking for \nsomething",
            style: const TextStyle(
              fontSize: 16, // Adjust the font size as needed
              fontFamily: "UBUNTU",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
