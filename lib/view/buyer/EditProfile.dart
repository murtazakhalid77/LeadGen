import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth_user;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import 'package:lead_gen/model/UserDto.dart';
import 'package:lead_gen/services/UserService.dart';
import 'package:lead_gen/view/buyer/myProfile.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';

class EditProfile extends StatefulWidget {
  final User user; // Define the user field here

  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late UserService userService;
  bool isLoading = false;
  late String profilePicPath;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
    phoneController = TextEditingController(text: widget.user.phoneNumber);
    emailController = TextEditingController(text: widget.user.email);
    userService = UserService();
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> uploadImageAndSaveUser() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    if (_imageFile != null) {
      // Upload image to Firebase Storage
      try {
        String fileName = path.basename(_imageFile!.path);
        Reference ref = _storage.ref().child('uploads/$fileName');
        UploadTask uploadTask = ref.putFile(File(_imageFile!.path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        profilePicPath = await taskSnapshot.ref.getDownloadURL();

        await fetchUser(nameController.text, lastNameController.text,
            phoneController.text, emailController.text, widget.user.email);

 firebase_auth_user.FirebaseAuth firebaseAuth = firebase_auth_user.FirebaseAuth.instance;


      // Get the current user's UID
      String userId = firebaseAuth.currentUser!.uid;
        if (userId!= null && userId.isNotEmpty) {
          await firestore.collection('users').doc(userId).set({
            'profilePic': profilePicPath,
          }, SetOptions(merge: true));
        } else {
          print('Error: User UID is null or empty');
          // Handle the error, such as showing a toast or logging
        }

        Timer(Duration(seconds: 5), () {
          setState(() {
            isLoading = false;
          });
        });
      } catch (e) {
        Timer(Duration(seconds: 5), () {
          setState(() {
            isLoading = false;
          });
        });
        print('Error uploading image: $e');
        showCustomToast('Error uploading image');
      }
    } else {
      Timer(Duration(seconds: 5), () {
        setState(() {
          isLoading = false;
        });
      });
      // Save user data without image
      await fetchUser(nameController.text, lastNameController.text,
          phoneController.text, emailController.text, widget.user.email);
    }
  }

  Future<void> fetchUser(String name, String lastName, String updatedPhone,
      String updatedEmail, String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      setState(() {
        isLoading = true;
      });
      // print("Image Path: $image");
      var response = await userService.editUserProfile(
          name, lastName, updatedPhone, updatedEmail, email);

      if (response.statusCode == 200) {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => ProfilePage(
        //       name: nameController.text + " " + lastNameController.text,
        //       phone: phoneController.text,
        //       email: updatedEmail,
        //       profilePicPath: profilePicPath,
        //       cnic: widget.user.cnic,
        //       userType: widget.user.userType),
        // ));
        Navigator.pop(context, 'refresh');
      } else {
        Timer(Duration(seconds: 5), () {
          setState(() {
            isLoading = false;
          });
        });
        print(response.body);
        showCustomToast(response.body);
      }
    } catch (error) {
      Timer(Duration(seconds: 5), () {
        setState(() {
          isLoading = false;
        });
      });
      print('Error updating User: $error');
      showCustomToast("error while updating logged In User");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                            child: _imageFile != null
                                ? Image.file(File(_imageFile!.path))
                                : Image.asset('lib/assets/man.png'),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => UploadPicture()),
                              );
                            },
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.teal,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),

                    // -- Form Fields
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          buildTextFormField('First Name', nameController,
                              CupertinoIcons.person),
                          const SizedBox(height: 10),
                          buildTextFormField('Last Name', lastNameController,
                              CupertinoIcons.person),
                          const SizedBox(height: 10),
                          buildForPhoneNumber(
                              'Phone', phoneController, CupertinoIcons.phone),
                          const SizedBox(height: 10),
                          buildForEmail(
                              'Email', emailController, CupertinoIcons.mail),
                          const SizedBox(height: 30),
                          // -- Form Submit Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  uploadImageAndSaveUser();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: const EdgeInsets.all(20),
                                side: BorderSide.none,
                                shape: const StadiumBorder(),
                              ),
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
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
            if (isLoading)
              Container(
                color: Colors.grey.withOpacity(0.6),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                ),
              ),
          ],
        ));
  }

  Widget UploadPicture() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource imageSource) async {
    final pickedfile = await _picker.pickImage(source: imageSource);
    setState(() {
      _imageFile = pickedfile;
    });
  }

  Widget buildTextFormField(
      String label, TextEditingController controller, IconData prefixIcon) {
    print(controller.text);
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter your First Name';
          }
          // Check if the input contains only alphabets
          if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
            return 'Enter only alphabets';
          }
          return null;
        },
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

  Widget buildForEmail(
      String label, TextEditingController controller, IconData prefixIcon) {
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
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email is empty';
          }
          if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
            if (value.isNotEmpty) {
              return 'Enter a valid email';
            } else {
              return null; // Return null if email is empty and no validation yet
            }
          }
          return null; // Return null for valid email
        },
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

  Widget buildForPhoneNumber(
      String label, TextEditingController controller, IconData prefixIcon) {
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
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value == null || value.isEmpty || value.length != 11) {
            return 'Enter a valid Phone Number with 11 digits';
          }
          return null;
        },
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
