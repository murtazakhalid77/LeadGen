class User {
  String firstName;
  String email;
  String phoneNumber;
  String location;
  
  User({this.firstName = '', this.email = '', this.phoneNumber = '',this.location=''});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'email': email,
      'phoneNumber': phoneNumber,
      'adress':location
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      location: json['adress'] ?? '',
    );
  }
}
