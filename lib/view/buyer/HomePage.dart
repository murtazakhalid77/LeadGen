import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart ' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_gen/constants/routes.dart';

import 'package:lead_gen/model/UserDto.dart';
import 'package:lead_gen/model/category.dart';
import 'package:lead_gen/services/UserService.dart';
import 'package:lead_gen/services/categoryService.dart';
import 'package:lead_gen/view/buyer/make_request.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/drawer/drawer.dart';
import 'package:lead_gen/view/seller/Seller-Home-Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  final bool option;

  const MyHomePage({Key? key, required this.option, required String email})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late UserService userService;
  late CategoryService categoryService;

  late User user;
  late List<Map<String, dynamic>> categories =
      []; // Initialize categories as an empty list;
  @override
  void initState() {
    user = User();
    userService = UserService();
    categoryService = CategoryService();
    super.initState();
    fetchUser();
  }

  Future<void> fetchCategories() async {
    try {
      // Fetch all categories
      List<Map<dynamic, dynamic>> fetchedCategories =
          await categoryService.fetchCategoriesForHomePage();

      if (widget.option) {
        // Filter categories to include only those in the user's categories
        List<Map<dynamic, dynamic>> userCategories = [];
        for (var category in fetchedCategories) {
          if (user.categories.contains(category['categoryName'])) {
            userCategories.add(category);
          }
        }
        setState(() {
          categories = userCategories.cast<Map<String, dynamic>>();
          print(categories);
        });
      } else {
        // Show all fetched categories
        setState(() {
          categories = fetchedCategories.cast<Map<String, dynamic>>();
        });
      }
    } catch (error) {
      print('Error fetching Categories: $error');
    }
  }

// Function to convert string representation to IconData
  IconData getIconData(String iconName) {
    switch (iconName) {
      case 'Technology':
        return Icons.computer;
      case 'Fashion':
        return Icons.accessibility_new;
      case 'Food & Cooking':
        return Icons.restaurant_menu;
      case 'Travel & Tourism':
        return Icons.airplanemode_active;
      case 'Health & Fitness':
        return Icons.fitness_center;
      case 'Home & Decor':
        return Icons.home;
      case 'Education':
        return Icons.school;
      case 'Sports & Recreation':
        return Icons.sports_soccer;
      case 'Arts &  Entertainment':
        return Icons.palette;
      case 'Business & Finance':
        return Icons.attach_money;
      case 'Cars':
        return Icons.directions_car;
      case 'Real Estate':
        return Icons.home_work;
      case 'Electronics':
        return Icons.devices;
      case 'Bikes':
        return Icons.directions_bike;
      default:
        return Icons.error; // Default icon in case of an unknown category
    }
  }

  Color parseColor(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'deeporange':
        return Colors.deepOrange;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'orange':
        return Colors.orange;
      case 'cyan':
        return Colors.cyan;
      case 'teal':
        return Colors.teal;
      case 'amber':
        return Colors.amber;
      case 'indigo':
        return Colors.indigo;
      case 'brown':
        return Colors.brown;
      case 'lime':
        return Colors.lime;
      case 'grey':
        return Colors.grey;
      case 'black':
        return Colors.black;
      // Add more cases for other known color strings
      default:
        if (colorString.isNotEmpty &&
            colorString.length >= 7 &&
            colorString[0] == '#') {
          try {
            return Color(
                int.parse(colorString.substring(1), radix: 16) + 0xFF000000);
          } catch (e) {
            print('Error parsing color: $e');
          }
        }
        return Colors
            .transparent; // Default color in case of an error or unknown color string
    }
  }

  Future<void> fetchUser() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email')!;
    User? loggedInUser = await userService.getLoggedInUser(email);
    
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

    if (firebaseAuth.currentUser != null) {
      // Get the current user's UID
      String userId = firebaseAuth.currentUser!.uid;

      try {
        // Retrieve image path from Firestore
        DocumentSnapshot userSnapshot = await firestore.collection('users').doc(userId).get();
        String imagePath = userSnapshot['imagePath'] as String;

        if (loggedInUser != null) {
          setState(() {
            user.firstName = loggedInUser.firstName;
            user.email = loggedInUser.email;
            user.location = loggedInUser.location;
            user.email = email; // Is this assignment necessary?
            user.phoneNumber = loggedInUser.phoneNumber;
            user.categories = loggedInUser.categories;
            user.profilePicPath = imagePath;
            print(user.toJson());
          });
        }
        fetchCategories();
      } catch (error) {
        print('Error fetching User: $error');
        showCustomToast("Error while fetching logged in User");
      }
    }
  } catch (error) {
    print('Error fetching user: $error');
    showCustomToast("Error while fetching user");
  }
}


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, user_Selection);
        return false; // Prevent default back button behavior
      },
      child: Scaffold(
        drawer: NavBar(userType: 'buyer', user: user),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(90),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: Text(
                      widget.option
                          ? "Hello Seller ${user.firstName} !!"
                          : "Hello Buyer ${user.firstName} !!",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white),
                    ),
                    subtitle: Text('Good Morning',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white54)),
                    trailing:  CircleAvatar(
                      radius: 30,
                     backgroundImage: NetworkImage(user.profilePicPath ?? 'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg'),
                    ), // Use a local asset as default,
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  children: categories.map<Widget>((category) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to another page here with the category name
                        String categoryName =
                            category['categoryName'] as String;
                        if (widget.option) {
                          print(categoryName);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MakeRequestPage(categoryName: categoryName),
                            ),
                          );
                        } else {
                          MaterialPageRoute(
                            builder: (context) =>
                                SellerHomePage(categoryName: categoryName),
                          );
                        }
                      },
                      child: itemDashboard(
                        category['categoryName'] as String,
                        getIconData(category['icons'] as String),
                        parseColor(category['backgroundColor'] as String),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => InkWell(
        onTap: () {
          if (widget.option) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SellerHomePage(
                  categoryName: title,
                ),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MakeRequestPage(
                  categoryName: title,
                ),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color: Theme.of(context).primaryColor.withOpacity(.2),
                    spreadRadius: 2,
                    blurRadius: 5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: Colors.white)),
              const SizedBox(height: 8),
              Center(
                child: Text(title.toUpperCase(),
                    textAlign: TextAlign
                        .center, // Aligning the category names in buttons in center
                    style: Theme.of(context).textTheme.titleMedium),
              )
            ],
          ),
        ),
      );
}
