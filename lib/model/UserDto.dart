import 'package:lead_gen/model/category.dart';

class User {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String location;
  String uid;
  List<String> categories;
  String profilePicPath;
  String cnic;
  String userType;

  User(
      {this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.phoneNumber = '',
      this.location = '',
      this.uid = '',
      this.categories = const [],
      this.cnic = '',
      this.userType = '',
      this.profilePicPath = ''});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'adress': location,
      'uid': uid,
      'categories': categories,
      'profilePicPath':profilePicPath,
    };
  }

factory User.fromJson(Map<String, dynamic> json) {
  return User(
    firstName: json['firstName'] ?? '',
    email: json['email'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
    location: json['adress'] ?? '',
    uid: json['uid'] ?? '',
    categories: (json['categories'] as List<dynamic>?) // Access the 'categories' field as a list
            ?.map((category) => category as String) // Map each category name to a String
            .toList() ??
        [],
    profilePicPath: json['profilePicPath'] ?? ''
  );
}


}
