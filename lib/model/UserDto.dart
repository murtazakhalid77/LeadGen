class User {
  String firstName;
  String email;
  String phoneNumber;
  String location;
  String uid;
  
  User({this.firstName = '', this.email = '', this.phoneNumber = '',this.location='',this.uid=''});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'email': email,
      'phoneNumber': phoneNumber,
      'adress':location,
      'uid':uid
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      location: json['adress'] ?? '',
      uid: json['uid'] ?? ''
    );
  }
}
