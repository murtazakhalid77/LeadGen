import 'package:flutter/material.dart';
import 'package:lead_gen/view/buyer/all_categories.dart';

class VehiclesPage extends StatelessWidget {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          elevation: 0.2,
          title: const Text(
            'Vehicles',
          ),
          leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Unfocus the current focus node before popping the screen
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                     const AllCategoriesPage(), // goes to all categories page
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

  
            ),
          ),
        ],
      ),
    );
  }
}
