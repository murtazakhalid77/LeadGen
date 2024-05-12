class Registration{
  String firstName;
  String lastName;
  String cnic;
  String email;
  String phoneNumber;
  String? fcmToken;
  String uid;
  Registration(this.uid,this.firstName, this.lastName,this.cnic,this.email,this.phoneNumber,this.fcmToken);

   Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'cnic': cnic,
      'email': email,
      'phoneNumber':phoneNumber,
      'fcmToken':fcmToken,
      'uid':uid
    };
  }

}