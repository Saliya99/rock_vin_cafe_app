class UserModel {
  String userId;
  int phoneNumber;
  String firstName;
  String lastName;
  String address;
  String city;
  String email;

  UserModel({
    required this.userId,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userid'] as String,
      phoneNumber: map['phoneno'] as int,
      firstName: map['fname'] as String,
      lastName: map['lname'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      email: map['email'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': userId,
      'phoneno': phoneNumber,
      'fname': firstName,
      'lname': lastName,
      'address': address,
      'city': city,
      'email': email,
    };
  }

  List<dynamic> dataToList() {
    return [userId, phoneNumber, firstName, lastName, address, city, email];
  }

  String tableColumns() {
    return 'userid, phoneno, fname, lname, address, city, emailaddress';
  }
}
