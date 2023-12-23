import 'package:flutter/material.dart';
import 'package:lead_gen/view/buyer/all_categories.dart';
import 'package:lead_gen/view/buyer/make_request.dart';
import 'package:lead_gen/view/drawer/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildImageWithText(String imagePath, String imageName) {
    return Column(
      children: [
        Image.asset(imagePath, height: 80),
        const SizedBox(height: 5),
        Text(imageName),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(userType: 'buyer'),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0.2,
        title: const Text(
          'Home',
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            // adds scrolling in page
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: 10,
                  left: 10),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 300),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none,
                          color: Colors.black, size: 30),
                      onPressed: () {
                        // Unfocus the current focus node before popping the screen
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.of(context)
                            .pop(); // Add navigation functionality here
                      },
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Make Request Button
                  ElevatedButton(
                    onPressed: () {
                      // Unfocus the current focus node before popping the screen
                      FocusManager.instance.primaryFocus?.unfocus();

                      // Navigate to the Make Request page
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              const MakeRequestPage(), // goes to home page
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(18),
                      child: Center(
                        child: Text(
                          'Make Your Request',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Center(
                    child: Text(
                      'Categories',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    height: 200,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          // First row of images
                          Row(
                            children: [
                              _buildImageWithText(
                                  'assets/cars.png', 'Vehicles'),
                                  const SizedBox(width: 15),
                              _buildImageWithText(
                                  'assets/bike.jpg', 'Bikes'),
                                  const SizedBox(width: 15),
                              _buildImageWithText(
                                  'assets/businesses.png', '   Businesses'),
                                  const SizedBox(width: 15),
                              _buildImageWithText(
                                  'assets/property.png', 'Property'),
                                  const SizedBox(width: 15),
                              _buildImageWithText(
                                  'assets/mobile.jpg', 'Mobile   '),
                                  const SizedBox(width: 15),
                              _buildImageWithText(
                                  'assets/homeappliances.png',
                                  'Home Appliances \n    & Electronics'),
                                  const SizedBox(width: 15),
                              _buildImageWithText(
                                  'assets/services.png', 'Services'),
                                  const SizedBox(width: 15),
                            ],
                          ),
                          // Add some spacing between rows
                          const SizedBox(width: 10),
                          // Second row of images
                          Row(
                            children: [
                              _buildImageWithText(
                                  'assets/jobs.png', 'Jobs'),
                                  const SizedBox(width: 15),
                              _buildImageWithText(
                                  'assets/furniture and home decore.png',
                                  'Furniture & \nHome Decor'),
                                  const SizedBox(width: 15),
                              _buildImageWithText(
                                  'assets/kids.png', 'Kids'),
                                  const SizedBox(width: 15),
                              _buildImageWithText(
                                  'assets/fashion and accessories.png',
                                  'Fashion & \nAccessories'),
                                  const SizedBox(width: 15),
                              _buildImageWithText(
                                  'assets/hobbies.png', 'Hobbies'),
                                  const SizedBox(width: 15),
                              _buildImageWithText(
                                  'assets/books.png', 'Books'),
                                  const SizedBox(width: 15),
                              _buildImageWithText(
                                  'assets/animals.png', 'Animals'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  //See All Categories Text Button
                  GestureDetector(
                    onTap: () {
                      // Navigate to AllcategoriesPage when "Sign Up" is clicked
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                               const AllCategoriesPage(), // goes to all categories page
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'See All categories',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
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
