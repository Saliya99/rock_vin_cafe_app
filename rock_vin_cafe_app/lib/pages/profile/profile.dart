import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/auth_controller.dart';
import 'package:rock_vin_cafe_app/controllers/database_controller.dart';
import 'package:rock_vin_cafe_app/models/user_model.dart';
import 'package:rock_vin_cafe_app/pages/auth/edit_profile.dart';
import 'package:rock_vin_cafe_app/pages/card_page/card_page.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';

class ProfileViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final databases = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.buttonBackgroungColor,
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          child: SingleChildScrollView(
            child: FutureBuilder<UserModel>(
              future: databases.readUserData("user", auth.currentUser!.uid),
              builder: (context, snapshot) {
                print(auth.currentUser!.uid);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 100,
                    width: 100.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Loading...'),
                        SizedBox(height: 16),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('No data available');
                } else {
                  final userModel = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 100.w,
                            color: AppColors.buttonBackgroungColor,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage(
                                          'https://xsgames.co/randomusers/assets/avatars/male/31.jpg'),
                                    ),
                                    Container(
                                      width: 58.w,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            userModel.fname +
                                                " " +
                                                userModel.lname,
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: AppColors.titleColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            userModel.emailaddress,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.paraColor,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          SizedBox(
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: AppColors.mainColor,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                    Radius.circular(50.0),
                                                  ))),
                                              onPressed: () {
                                                // Handle sign out button press
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditProfile(
                                                              btnName:
                                                                  'Update Profile',
                                                            )));
                                              },
                                              child: Text('Edit profile'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: 98.w,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Personal Info',
                                  style: TextStyle(
                                    fontSize: 8.w,
                                    color: AppColors.titleColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                personalDetails("First Name", userModel.fname),
                                personalDetails("Last Name", userModel.lname),
                                personalDetails(
                                    "Email", userModel.emailaddress),
                                personalDetails("Address", userModel.address),
                                personalDetails("City", userModel.city),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.all(16),
                            color: AppColors.buttonBackgroungColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Wallet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.titleColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Add Debit or Credit Card',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.paraColor,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CardDetailsPage()));
                                        },
                                        icon: FaIcon(
                                          Icons.add,
                                          color: Colors.green,
                                        ))
                                  ],
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppColors.titleColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                      Radius.circular(50.0),
                                    ))),
                                onPressed: () {
                                  // Handle sign out button press
                                  final auth = Provider.of<AuthBase>(context,
                                      listen: false);
                                  auth.signOut();
                                },
                                child: Text('Sign Out'),
                              ),
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              height: 50,
                              // child:
                              // ElevatedButton(
                              //   style: ElevatedButton.styleFrom(
                              //       primary: Colors.red,
                              //       shape: const RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.all(
                              //         Radius.circular(50.0),
                              //       ))),
                              //   onPressed: () {
                              //     // Handle sign out button press
                              //   },
                              //   child: Text('Delete Account'),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Padding personalDetails(String type, String data) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Text(
        '$type: $data',
        style: TextStyle(
          fontSize: 5.w,
          color: AppColors.paraColor,
        ),
      ),
    );
  }
}
