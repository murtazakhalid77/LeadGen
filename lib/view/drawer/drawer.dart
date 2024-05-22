import 'package:flutter/material.dart';
import 'package:lead_gen/model/UserDto.dart';
import 'package:lead_gen/view/Chats/all_chats.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/buyer/myProfile.dart';
import 'package:lead_gen/view/myAllRequests/my_requests.dart';
import 'package:lead_gen/view/signupAndLogin/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatelessWidget {
  final User? user;

  NavBar({Key? key, required this.user}) : super(key: key);

  // Function to clear shared preferences
  Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Function to log out
  void logout(BuildContext context) {
   showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text('Logout', style: TextStyle(color: Colors.black)),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action here
                _performLogout(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue.shade100,
              ),
              child: Text('Logout'),
            ),
          ],
        );
      },
    );// Clear shared preferences
  }

 Future<void> _performLogout(BuildContext context) async {
 final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  
  Navigator.of(context).pop();
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => LoginScreen(phoneNumber: '')),
    (route) => false,
  );

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
              if (user!.userType == 'BUYER') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(
                      option: false,
                      email: user!.email, // Navigate to seller home page
                    ),
                  ),
                );
              }
            },
          ),
          if (user!.userType == 'BOTH') ...[
            ListTile(
              leading: const Icon(
                Icons.feed,
                color: Colors.purple,
                size: 25,
              ),
              title: const Text(
                'Buyer Request',
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.purple,
              onTap: () {
                print('Requests tapped for ${user!.userType}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyRequests(
                      email: user!.email,
                      option: true,
                    ),
                  ),
                );
              },
            ),
          ] else if (user!.userType == 'both') ...[
            ListTile(
              leading: const Icon(
                Icons.feed,
                color: Colors.purple,
                size: 25,
              ),
              title: const Text(
                'Buyer Request',
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.purple,
              onTap: () {
                print('Requests tapped for ${user!.userType}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyRequests(
                      email: user!.email,
                      option: true,
                    ),
                  ),
                );
              },
            ),
          ],
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    name: user!.firstName,
                    phone: user!.phoneNumber,
                    email: user!.email,
                    profilePicPath: user!.profilePicPath,
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
            logout(context); // Show the logout dialog
            },
          ),
        ],
      ),
    );
  }
}
