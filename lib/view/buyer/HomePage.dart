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
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  final String phoneNumber;

  const MyHomePage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late UserService userService;
  late CategoryService categoryService;
  late String phoneNumber;
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
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      List<Map<dynamic, dynamic>> fetchedCategories =
          await categoryService.fetchCategoriesForHomePage();

      if (fetchedCategories != null) {
        setState(() {
          categories = fetchedCategories.cast<Map<String, dynamic>>();
        });
      }

      print(categories);
    } catch (error) {
      print('Error fetching Categories: $error');
    }
  }

// Function to convert string representation to IconData
  IconData getIconData(String iconName) {
    switch (iconName) {
      case 'car':
        return CupertinoIcons.car; // Replace with appropriate IconData
      case 'house':
        return CupertinoIcons.house; // Replace with appropriate IconData
      // Add more cases for other icons if needed
      default:
        return Icons.error; // Default icon in case of an unknown icon name
    }
  }

  Color parseColor(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'deeporange':
        return Colors.deepOrange;
      case 'green':
        return Colors.green;
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
      phoneNumber = prefs.getString('phoneNumber')!;
      User? loggedInUser = await userService.getLoggedInUser(phoneNumber!);

      if (loggedInUser != null) {
        setState(() {
          user.firstName = loggedInUser.firstName;
          user.email = loggedInUser.email;
          user.location = loggedInUser.location;
          user.phoneNumber = widget.phoneNumber;
          print(user.toJson());
        });
      }
    } catch (error) {
      print('Error fetching User: $error');
      showCustomToast("error while fetching logged In User");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, user_Selection);
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
                    title: Text("Hello ${user!.firstName} !!",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white)),
                    subtitle: Text('Good Morning',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white54)),
                    trailing: const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg"),
                    ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MakeRequestPage(
                              categoryName: categoryName,
                              phoneNumber: phoneNumber,
                            ),
                          ),
                        );
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

  itemDashboard(String title, IconData iconData, Color background) =>
      GestureDetector(
        onTap: () {
          String categoryName = title;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MakeRequestPage(
                categoryName: categoryName,
                phoneNumber: '',
              ),
            ),
          );
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
              Text(title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
        ),
      );
}
