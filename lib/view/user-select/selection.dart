import 'package:flutter/material.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/seller/Seller-Home-Page.dart';

enum UserType {
  buyer,
  seller,
}

class SelectionPage extends StatefulWidget {
  final String phoneNumber;
  final UserType userType;

  const SelectionPage({
    Key? key,
    required this.phoneNumber,
    required this.userType,
  }) : super(key: key);

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
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
                  Center(
                    child: widget.userType == UserType.seller
                        ? ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SellerHomePage(),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.grey[350],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10),
                                Icon(Icons.shopping_cart_rounded),
                                SizedBox(height: 15),
                                Text(
                                  "Want to sell \nsomething",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "UBUNTU",
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          )
                        : widget.userType == UserType.buyer
                            ? ElevatedButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(phoneNumber: widget.phoneNumber),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.grey[350],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 10),
                                    Icon(Icons.search),
                                    SizedBox(height: 15),
                                    Text(
                                      "Looking for \nsomething",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "UBUNTU",
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SellerHomePage(),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.grey[350],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                    ),
                                    child: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 10),
                                        Icon(Icons.shopping_cart_rounded),
                                        SizedBox(height: 15),
                                        Text(
                                          "Want to sell \nsomething",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "UBUNTU",
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyHomePage(phoneNumber: widget.phoneNumber),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.grey[350],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                    ),
                                    child: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 10),
                                        Icon(Icons.search),
                                        SizedBox(height: 15),
                                        Text(
                                          "Looking for \nsomething",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "UBUNTU",
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
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
    );
  }
}
