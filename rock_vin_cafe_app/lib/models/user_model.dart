class UserModel {
  String userid;
  String phoneno;
  String fname;
  String lname;
  String address;
  String city;
  String emailaddress;

  UserModel({
    required this.userid,
    required this.phoneno,
    required this.fname,
    required this.lname,
    required this.address,
    required this.city,
    required this.emailaddress,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userid: map['userid'] as String,
      phoneno: map['phoneno'] as String,
      fname: map['fname'] as String,
      lname: map['lname'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      emailaddress: map['emailaddress'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'phoneno': phoneno,
      'fname': fname,
      'lname': lname,
      'address': address,
      'city': city,
      'emailaddress': emailaddress,
    };
  }

  List<dynamic> dataToList() {
    return [userid, phoneno, fname, lname, address, city, emailaddress];
  }

  String tableColumns() {
    return 'userid, phoneno, fname, lname, address, city, emailaddress';
  }
}
