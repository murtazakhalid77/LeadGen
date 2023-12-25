import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_gen/view/buyer/EditProfile.dart';

class ProfilePage extends StatelessWidget {
  final String? name;
  final String? phone;
  final String? address;
  final String? email;

  const ProfilePage({
    Key? key,
    this.name,
    this.phone,
    this.address,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              'My Profile',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('lib/assets/man.png'),
            ),
            const SizedBox(height: 20),
            itemProfile('Name', name ?? 'N/A', CupertinoIcons.person),
            const SizedBox(height: 10),
            itemProfile('Phone', phone ?? 'N/A', CupertinoIcons.phone),
            const SizedBox(height: 10),
            itemProfile('Address', address ?? 'N/A', CupertinoIcons.location),
            const SizedBox(height: 10),
            itemProfile('Email', email ?? 'N/A', CupertinoIcons.mail),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EditProfile(),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.blueAccent.withOpacity(.3),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}
