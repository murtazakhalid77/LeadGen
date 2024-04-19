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
final String phoneNumber;
  const CategoryRegistration(
      {Key? key, required this.phoneNumber})
      : super(key: key);

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
  //  fetchUser();
    fetchCategories();
  }

  Future<void> setCategories() async {
    try {
      int response = await userService.setCategory(widget.phoneNumber, this.selectedCategories);


      if(response == 200){
        Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>  const LoginScreen(phoneNumber: '',), 
                    ),
                  );
        showCustomToast("Successfully registered as a Seller!!!");
      }
    
      // print(categories);
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

      print(categories);
    } catch (error) {
      print('Error fetching Categories: $error');
    }
  }

  IconData getIconData(String iconName) {
    switch (iconName) {
      case 'car':
        return CupertinoIcons.car;
      case 'house':
        return CupertinoIcons.house;
      default:
        return Icons.error;
    }
  }

  Color parseColor(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'deeporange':
        return Colors.deepOrange;
      case 'green':
        return Colors.green;
      default:
        if (colorString.isNotEmpty &&
            colorString.length >= 7 &&
            colorString[0] == '#') {
          try {
            return Color(int.parse(colorString.substring(1), radix: 16) +
                0xFF000000);
          } catch (e) {
            print('Error parsing color: $e');
          }
        }
        return Colors.transparent;
    }
  }

 /* Future<void> fetchUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String phoneNumber = prefs.getString('phoneNumber')!;
      User? loggedInUser =
          await userService.getLoggedInUser(phoneNumber);

      if (loggedInUser != null) {
        setState(() {
          user.firstName = loggedInUser.firstName;
          user.email = loggedInUser.email;
          user.location = loggedInUser.location;
          user.phoneNumber = phoneNumber;
          print(user.toJson());
        });
      }
    } catch (error) {
      print('Error fetching User: $error');
      showCustomToast("error while fetching logged In User");
    }
  }*/

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
                  /*  subtitle: Text('Good Morning',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white54)),*/
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
                            if(selectedCategories.length < 4) {
                              selectedCategories.add(categoryName);
                              print(selectedCategories);
                            } else {
                              // Handle maximum selection alert here
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
            if(selectedCategories.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    setCategories();
                  
                  },
                  child: const Text('Done'),
                ),
              )
          ],
        ),
      );  
  }

  Widget itemDashboard(String title, IconData iconData, Color background, bool isSelected) {
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
            child: isSelected ? const Icon(Icons.check, color: Colors.green) : Icon(iconData, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(title.toUpperCase(), style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }}