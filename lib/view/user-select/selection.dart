import 'package:flutter/material.dart';
import 'package:lead_gen/view/buyer/Home.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 300, // Adjust the height as needed
            child: Image(
              image: AssetImage("assets/splashscreen.png"),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SellerHomePage()),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                  ),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10,),
                    Icon(Icons.shopping_cart_rounded),
                    SizedBox(height: 15),
                    Text(
                      "Want to sell \nsomething",
                      style: TextStyle(
                        fontSize: 16, // Adjust the font size as needed
                        fontFamily: "UBUNTU",
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                  ),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10,),
                    Icon(Icons.search),
                    SizedBox(height: 15),
                    Text(
                      "Looking for \nsomething",
                      style: TextStyle(
                        fontSize: 16, // Adjust the font size as needed
                        fontFamily: "UBUNTU",
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
