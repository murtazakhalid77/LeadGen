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
      'phone': phoneNumber,
      'adress':location
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone'] ?? '',
      location: json['adress'] ?? '',
    );
  }
}
