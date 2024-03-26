import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lead_gen/model/UserDetails.dart';
import 'package:lead_gen/services/UserService.dart';

import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/seller/Seller-Home-Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectionPage extends StatefulWidget {
  final String phoneNumber;
  const SelectionPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  late String phoneNumber;
  late UserService userService;
  late UserType userType;
  late Bool option;
  @override
  void initState() {
    super.initState();
    userService = UserService();
    userType = UserType();
    phoneNumber = widget.phoneNumber;
    fetchData();
  }

 Future<void> fetchData() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phoneNumber = prefs.getString('phoneNumber');

    if (phoneNumber != null) {
      UserType? userType = await userService.getUserType(phoneNumber);

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
                  buildElevatedButtons(context, widget.phoneNumber, this.userType.user_Type),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildElevatedButtons(BuildContext context, String phoneNumber, String type) {
  if (type == "BOTH") {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildElevatedButton(phoneNumber, context, true,true),
        buildElevatedButton(phoneNumber, context, false,false),
      ],
    );
  } else {
  
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (type == "SELLER")buildElevatedButton(phoneNumber, context, true,true),
        if (type == "BUYER") buildElevatedButton(phoneNumber, context, false,false),
      ],
    );
  }
}

Widget buildElevatedButton(String phoneNumber, BuildContext  context, bool condition,bool option) {

  return ElevatedButton(
  
    onPressed: condition
        ? () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(option: option, phoneNumber: '',)),
              // MaterialPageRoute(builder: (context) => SellerHomePage(option: option)),
            )
        : () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage( option: option, phoneNumber: '',)),
            ),
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30), // Adjust padding as needed
      foregroundColor: Colors.black,
      backgroundColor: Colors.grey[350],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
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

