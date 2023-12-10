import 'package:flutter/material.dart';
import 'package:lead_gen/view/buyer/Home.dart';
import 'package:lead_gen/view/buyer/vehicles.dart';

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({Key? key}) : super(key: key);

  Widget _buildCategoryRow(String imagePath, String categoryName, BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the corresponding vehicle page when clicked
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const VehiclesPage(), //  goes to Vehicles page
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image and Text
            Row(
              children: [
                Image.asset(
                  imagePath,
                  height: 50,
                ),
                const SizedBox(width: 20),
                Text(
                  categoryName,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            // Forward Arrow
            const Icon(Icons.arrow_forward, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0.2,
        title: const Text('All Categories'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Unfocus the current focus node before popping the screen
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                right: 35,
                left: 35,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Here are All Categories',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    height: 600,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          // Rows of images with text and arrows
                          _buildCategoryRow('assets/cars.png', 'Vehicles', context),
                          _buildCategoryRow('assets/bike.jpg', '         Bikes', context),
                          _buildCategoryRow('assets/businesses.png', '        Businesses', context),
                          _buildCategoryRow('assets/property.png', '        Property', context),
                          _buildCategoryRow('assets/mobile.jpg', '                 Mobile', context),
                          _buildCategoryRow(
                              'assets/homeappliances.png', '      Home Appliances \n       & Electronics', context),
                          _buildCategoryRow('assets/services.png', '          Services', context),
                          _buildCategoryRow('assets/jobs.png', '          Jobs', context),
                          _buildCategoryRow(
                              'assets/furniture and home decore.png', '     Furniture & \n     Home Decor', context),
                          _buildCategoryRow('assets/kids.png', '           Kids', context),
                          _buildCategoryRow(
                              'assets/fashion and accessories.png', '         Fashion & \n         Accessories', context),
                          _buildCategoryRow('assets/hobbies.png', '            Hobbies', context),
                          _buildCategoryRow('assets/books.png', '         Books', context),
                          _buildCategoryRow('assets/animals.png', '            Animals', context),
                        ],
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