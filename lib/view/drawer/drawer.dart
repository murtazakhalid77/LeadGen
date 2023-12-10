import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final String userType;

  const NavBar({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('John'),
            accountEmail: const Text('john345@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/man.png'),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.blue,
              size: 25,
            ),
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.blue,
            onTap: () {
              // Handle Home tapped based on user type
              print('Home tapped for $userType');
              // You can implement different logic based on user type
              if (userType == 'seller') {
                // Navigate to seller's home page
                Navigator.pushNamed(context, '/seller_home');
              } else if (userType == 'buyer') {
                // Navigate to buyer's home page
                Navigator.pushNamed(context, '/buyer_home');
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.feed,
              color: Colors.blue,
              size: 25,
            ),
            title: const Text(
              'Requests',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.blue,
            onTap: () {
              // Handle Requests tapped based on user type
              print('Requests tapped for $userType');
              // You can implement different logic based on user type
              if (userType == 'seller') {
                // Navigate to seller's requests page
                Navigator.pushNamed(context, '/seller-request');
              } else if (userType == 'buyer') {
                // Navigate to buyer's requests page
              //  Navigator.pushNamed(context, '/buyer_makeRequest');
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.chat,
              color: Colors.blue,
              size: 25,
            ),
            title: const Text(
              'Chats',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.blue,
            onTap: () {
              // Handle Requests tapped based on user type
              print('Chats tapped for $userType');
              // You can implement different logic based on user type
              if (userType == 'seller') {
                // Navigate to seller's requests page
            //    Navigator.pushNamed(context, '/sellerRequests');
              } else if (userType == 'buyer') {
                // Navigate to buyer's requests page
            //    Navigator.pushNamed(context, '/buyer_makeRequest');
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.blue,
              size: 25,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.blue,
           onTap: () {
              // Handle Requests tapped based on user type
              print('Profile tapped for $userType');
              // You can implement different logic based on user type
              if (userType == 'seller') {
                // Navigate to seller's requests page
             //   Navigator.pushNamed(context, '/sellerRequests');
              } else if (userType == 'buyer') {
                // Navigate to buyer's requests page
             //   Navigator.pushNamed(context, '/buyer_makeRequest');
              }
            },
          ),
        ],
      ),
    );
  }
}
