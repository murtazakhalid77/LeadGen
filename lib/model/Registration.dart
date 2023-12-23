class Registration{
  String firstName;
  String lastName;
  String cnic;
  String email;
  String phoneNumber;
  Registration(this.firstName, this.lastName,this.cnic,this.email,this.phoneNumber);

   Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'cnic': cnic,
      'email': email,
      'phoneNumber':phoneNumber
    };
  }

}