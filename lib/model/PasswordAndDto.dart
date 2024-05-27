
class PasswordAndDto {
   String password;
    String otp;
    
  
  PasswordAndDto({this.password ="", this.otp = ""});

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'otp': otp,
    
    };
  }

  factory PasswordAndDto.fromJson(Map<String, dynamic> json) {
    return PasswordAndDto(
      password: json['password'] ?? '',
      otp: json['otp'] ?? '',
         );
  }
}


