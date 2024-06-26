import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_gen/model/UserDto.dart';
import 'package:lead_gen/services/UserService.dart';
import 'package:lead_gen/view/buyer/EditProfile.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/drawer/drawer.dart';

class ProfilePage extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? profilePicPath;
  final String? email;
  final String? cnic;
  final String? userType;


  const ProfilePage({
    Key? key,
    this.name,
    this.phone,
    this.email,
    this.profilePicPath,
    this.cnic,
    this.userType
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserService userService;
  late User user;

  @override
  void initState() {
    user = User();
    userService = UserService();
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      // Replace the 'widget' with 'widget.' to access the properties of ProfilePage
      User? loggedInUser = await userService.getLoggedInUser(widget.email!);
       FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot userSnapshot =
              await firestore.collection('users').doc(loggedInUser!.uid).get();
          String? imagePath = userSnapshot['profilePic'] as String?;

      if (loggedInUser != null) {
        setState(() {
          user.firstName = loggedInUser.firstName;
          user.email = loggedInUser.email;
          user.uid=loggedInUser.uid;
          user.phoneNumber = widget.phone!;
          user.profilePicPath =imagePath!;
          user.cnic = loggedInUser.cnic;
          user.userType = loggedInUser.userType;
          user.lastName = loggedInUser.lastName;
        });
      }
    } catch (error) {
      print('Error fetching User: $error');
      showCustomToast("error while fetching logged In User");
    }
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
   //   drawer: NavBar(userType: 'buyer', user: user),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            // Unfocus the current focus node before popping the screen
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pop();// Add navigation functionality here
          },
        ),
        backgroundColor: Colors.lightBlue,
        elevation: 0.2,
        title: const Text(
          'Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 35),
              const Text(
                'My Profile',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blueAccent,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
               CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(user.profilePicPath)
               ),

              const SizedBox(height: 20),
              itemProfile('Name', widget.name ?? 'N/A', CupertinoIcons.person),
              const SizedBox(height: 10),
              itemProfile('Phone', widget.phone ?? 'N/A', CupertinoIcons.phone),
              const SizedBox(height: 10),
              itemProfile('Email', widget.email ?? 'N/A', CupertinoIcons.mail),
              const SizedBox(height: 10),
              itemProfile('CNIC', widget.cnic ?? 'N/A', CupertinoIcons.tag),
              const SizedBox(height: 10),
              itemProfile('Type', widget.userType ?? 'N/A', CupertinoIcons.mail),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
              builder: (context) => EditProfile(user: user),

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
        tileColor: Colors.white,
      ),
    );
  }
  
}
