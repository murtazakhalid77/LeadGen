import 'package:flutter/material.dart';
import 'package:lead_gen/view/buyer/Home.dart';
import 'package:lead_gen/view/seller/Seller-Home-Page.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
             Container(
              child: const SizedBox(
                height: 500,
                child: Image(
                  image : AssetImage("assets/splashscreen.png"),
                ),
              )
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 40),
              child: ElevatedButton.icon(
                label: const Text("Want to sell something."),
                icon: const Icon(Icons.shopping_cart_rounded),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontFamily: "UBUNTU"
                  )
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SellerHomePage()),
                  )
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                label: const Text("Looking for something."),
                icon: const Icon(Icons.search),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontFamily: "UBUNTU"
                  )
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  )
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
}