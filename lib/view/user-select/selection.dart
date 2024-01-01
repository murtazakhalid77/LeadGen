import 'package:flutter/material.dart';
import 'package:lead_gen/view/buyer/Home.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/seller/Seller-Home-Page.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SellerHomePage()),
                        ),
                        style: ElevatedButton.styleFrom(
                           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30), // Adjust padding as needed
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey[350],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Adjust the radius as needed
                          ),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Icon(Icons.shopping_cart_rounded),
                            SizedBox(height: 15),
                            Text(
                              "Want to sell \nsomething",
                              style: TextStyle(
                                fontSize: 16, // Adjust the font size as needed
                                fontFamily: "UBUNTU",
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage(phoneNumber: '',)),
                        ),
                        style: ElevatedButton.styleFrom(
                           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30), // Adjust padding as needed
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey[350],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Adjust the radius as needed
                          ),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Icon(Icons.search),
                            SizedBox(height: 15),
                            Text(
                              "Looking for \nsomething",
                              style: TextStyle(
                                fontSize: 16, // Adjust the font size as needed
                                fontFamily: "UBUNTU",
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
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
