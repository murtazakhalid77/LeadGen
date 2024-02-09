import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_gen/model/UserDto.dart';
import 'package:lead_gen/view/buyer/myProfile.dart';

class EditProfile extends StatefulWidget {
  final User user; // Define the user field here

  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}
class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController ;
  late TextEditingController phoneController;
  late TextEditingController addressController;
 late TextEditingController emailController;
 @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.firstName);
    phoneController = TextEditingController(text: widget.user.phoneNumber);
    addressController = TextEditingController(text: widget.user.location);
    emailController = TextEditingController(text: widget.user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            // Unfocus the current focus node before popping the screen
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).push(
             MaterialPageRoute(
                builder: (context) => const ProfilePage(), // goes to home page
              ),
            ); // Add navigation functionality here
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage('lib/assets/man.png')),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100), color: Colors.lightBlueAccent),
                      child: const Icon(
                        CupertinoIcons.camera, 
                        color: Colors.black, 
                        size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
  child: Column(
    children: [
      buildTextFormField('Name', nameController, CupertinoIcons.person),
      const SizedBox(height: 5),
      buildTextFormField('Phone', phoneController, CupertinoIcons.phone),
      const SizedBox(height: 5),
      buildTextFormField('Address', addressController, CupertinoIcons.location),
      const SizedBox(height: 5),
      buildTextFormField('Email', emailController, CupertinoIcons.mail),
      const SizedBox(height: 30),
                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Update data on ProfilePage
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              name: nameController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                              email: emailController.text,
                            ),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.all(20),
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Edit', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget buildTextFormField(String label, TextEditingController controller, IconData prefixIcon) {
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
        ),
      ],
    ),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
}