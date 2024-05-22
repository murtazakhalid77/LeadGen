import 'package:flutter/material.dart';
import 'package:lead_gen/model/UserDto.dart';
import 'package:lead_gen/view/Chats/all_chats.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';

import 'package:lead_gen/view/buyer/myProfile.dart';
import 'package:lead_gen/view/myAllRequests/my_requests.dart';
import 'package:lead_gen/view/signupAndLogin/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NavBar extends StatelessWidget {
  final String userType;
  final User? user;

  NavBar({Key? key, required this.userType, required this.user})
      : super(key: key);

      // Function to clear shared preferences
  Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Function to log out
  void logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(phoneNumber: ''), // Navigate to login screen
      ),
      (route) => false, // Remove all previous routes
    );
    clearSharedPreferences(); // Clear shared preferences
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user!.firstName),
            accountEmail: Text(user!.email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                
                child: Image.network(
                  user!.profilePicPath,
                 width: 90, // Ensure width and height are the same
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              backgroundColor: Colors.blue,
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.teal,
              size: 25,
            ),
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.teal,
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              if (userType == 'buyer') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(option: false, email: user!.email), // Navigate to seller home page
                  ),
                );
              }
            },         
          ),
          // Only show Requests option if the user is not a seller
         if (userType == 'buyer')
            ListTile(
              leading: const Icon(
                Icons.feed,
                color: Colors.purple,
                size: 25,
              ),
              title: const Text(
                'Requests',
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.purple,
              onTap: () {
                print('Requests tapped for $userType');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyRequests(email: user!.email, option: true,),
                  ),
                );
              },
            ),
          ListTile(
            leading: const Icon(
              Icons.chat,
              color: Colors.pink,
              size: 25,
            ),
            title: const Text(
              'Chats',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.pink,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllChatsPage(),
                ),
              );
              
              
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.indigo,
              size: 25,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.indigo,
            onTap: () {
              print(user!.toJson());
              // Handle Requests tapped based on user type
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    name: user!.firstName + " " + user!.lastName,
                    phone: user!.phoneNumber,
                    email: user!.email,
                    profilePicPath: user!.profilePicPath,
                    cnic: user!.cnic,
                    userType: user!.userType,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 250),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.blue,
              size: 25,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.blue,
            onTap: () {
              Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(phoneNumber: ''), // goes to login page
              ),
            );
            },
          )
        ],
      ),
    );
  }
}
