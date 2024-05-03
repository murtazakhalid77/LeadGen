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
import 'package:lead_gen/view/signupAndLogin/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryRegistration extends StatefulWidget {
  final String email;

  const CategoryRegistration({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<CategoryRegistration> createState() => _CategoryRegistrationState();
}

class _CategoryRegistrationState extends State<CategoryRegistration> {
  late UserService userService;
  late CategoryService categoryService;

  late User user;
  late List<Map<String, dynamic>> categories = [];

  late List<String> selectedCategories = [];

  @override
  void initState() {
    user = User();
    userService = UserService();
    categoryService = CategoryService();
    super.initState();
    fetchCategories();
  }

  Future<void> setCategories() async {
    try {
      int response =
          await userService.setCategory(widget.email, selectedCategories);

      if (response == 200) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(
              phoneNumber: '',
            ),
          ),
        );
        showCustomToast("Successfully registered as a Seller!!!");
      }
    } catch (error) {
      print('Error fetching Categories: $error');
    }
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
    } catch (error) {
      print('Error fetching Categories: $error');
    }
  }

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
        return Colors.transparent;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Hello Seller ${user.firstName} !!",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
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
                  final categoryName = category['categoryName'] as String;
                  final isSelected = selectedCategories.contains(categoryName);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedCategories.remove(categoryName);
                          print(selectedCategories);
                        } else {
                          if (selectedCategories.length < 4) {
                            selectedCategories.add(categoryName);
                            print(selectedCategories);
                          } else {
                            // Handle maximum selection alert here
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                title: const Text(
                                  'Maximum Categories Reached',
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                content: const Text(
                                  'You can select maximum 4 categories.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      });
                    },
                    child: itemDashboard(
                      categoryName,
                      getIconData(category['icons'] as String),
                      parseColor(category['backgroundColor'] as String),
                      isSelected,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: selectedCategories.isEmpty
                ? null // Disable button when no category is selected
                : () {
                    setCategories();
                  },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors
                        .grey.shade300; // Grey color when button is disabled
                  }
                  return Colors.blue; // Blue color when button is enabled
                },
              ),
            ),
            child: const Text(
              'Done',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemDashboard(
      String title, IconData iconData, Color background, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Theme.of(context).primaryColor.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.green)
                : Icon(iconData, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
