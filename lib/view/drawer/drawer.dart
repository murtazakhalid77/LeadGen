import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
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
            onTap: () => print('Home tapped'),
          ),
          ListTile(
            leading: const Icon(
              Icons.feed,
              color: Colors.blue,
              size: 25,
            ),
            title: const Text(
              'Feed',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.blue,
            onTap: () => print('Feed tapped'),
          ),
          ListTile(
            leading: const Icon(
              Icons.chat,
              color: Colors.blue,
              size: 25,
            ),
            title: const Text(
              'Chat',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.blue,
            onTap: () => print('Chat tapped'),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.blue,
              size: 25,
            ),
            title: const Text(
              'User',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.blue,
            onTap: () => print('User tapped'),
          ),
        ],
      ),
    );
  }
}
