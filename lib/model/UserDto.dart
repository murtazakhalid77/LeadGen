class User {
  String firstName;
  String email;
  String phoneNumber;
  
  User({this.firstName = '', this.email = '', this.phoneNumber = ''});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'email': email,
      'phone': phoneNumber,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone'] ?? '',
    );
  }
}
