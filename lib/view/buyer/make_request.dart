import 'package:flutter/material.dart';
import 'package:lead_gen/view/buyer/Home.dart';

class MakeRequestPage extends StatelessWidget {
  const MakeRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          elevation: 0.2,
          title: const Text(
            'Request',
          ),
          leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Unfocus the current focus node before popping the screen
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    const HomePage(), // goes to all categories page
              ),
            ); // Add navigation functionality here
          },
        ),
        ),
        backgroundColor: Colors.white,
        body: Stack(children: [
          SingleChildScrollView(
              // adds scrolling in page
              child: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                right: 35,
                left: 35 ),

                
          ))
        ]));
  }
}