import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart ' as firebase_auth;
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
   bool _needsRefresh = false;

   @override
  void initState() {
    user = User();
    userService = UserService();
    super.initState();
    fetchUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if this page was popped back to and needs refreshing
    if (_needsRefresh) {
      fetchUser();
      _needsRefresh = false; // Reset the flag
    }
  }

  Future<void> fetchUser() async {
  try {

    User? loggedInUser = await userService.getLoggedInUser(widget.email);

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

    if (firebaseAuth.currentUser != null) {
      // Get the current user's UID
      String userId = firebaseAuth.currentUser!.uid;
      String? imagePath;

      try {
        DocumentSnapshot userSnapshot = await firestore.collection('users').doc(userId).get();
        // Extract profilePic or set default
        imagePath = userSnapshot['profilePic'] as String?;
        imagePath = (imagePath == null || imagePath.isEmpty) 
            ? 'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg' 
            : imagePath;
      } catch (error) {
        // Handle Firestore document fetch error and set default image
        print('Error fetching User Snapshot: $error');
        showCustomToast("Error while fetching user profile picture.");
        imagePath = 'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg';
      }

      if (loggedInUser != null) {
        setState(() {
          user.firstName = loggedInUser.firstName;
          user.lastName = loggedInUser.lastName;
          user.location = loggedInUser.location;
          user.email = loggedInUser.email; // If necessary, set this here
          user.phoneNumber = loggedInUser.phoneNumber;
          user.categories = loggedInUser.categories;
          user.profilePicPath = imagePath!;
          user.cnic = loggedInUser.cnic;
          user.userType = loggedInUser.userType;
          print(user.toJson());
        });
      }
     
    }
  } catch (error) {
    print('Error fetching user: $error');
    showCustomToast("Error while fetching user.");
    // Fallback for user.profilePicPath if there's a top-level error
    setState(() {
      user.profilePicPath = 'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg';
    });
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
