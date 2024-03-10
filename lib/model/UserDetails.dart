class UserType{
  late String user_Type;

  UserType({this.user_Type = ''});

  Map<String, dynamic> toJson() {
    return {
      'userType': user_Type,
    };
  }

  factory UserType.fromJson(Map<String, dynamic> json) {
    return UserType(
      user_Type: json['userType'] ?? '',
    );
  }

}