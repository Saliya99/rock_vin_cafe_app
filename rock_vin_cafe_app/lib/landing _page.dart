import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/database_controller.dart';
import 'package:rock_vin_cafe_app/models/user_model.dart';
import 'package:rock_vin_cafe_app/pages/auth/edit_profile.dart';
import 'package:rock_vin_cafe_app/pages/auth/login_email.dart';
import 'package:rock_vin_cafe_app/pages/auth/login_phone.dart';
import 'package:rock_vin_cafe_app/pages/auth/welocme.dart';
import 'package:rock_vin_cafe_app/pages/card_page/card_page.dart';
import 'package:rock_vin_cafe_app/pages/food_cat/food_cat.dart';
import 'package:rock_vin_cafe_app/pages/home/home.dart';
import 'package:rock_vin_cafe_app/pages/home/home_page_2.dart';
import 'package:rock_vin_cafe_app/pages/order_page/order_h_page.dart';
import 'package:rock_vin_cafe_app/pages/order_page/order_page.dart';
import 'package:rock_vin_cafe_app/pages/profile/profile.dart';
import 'package:rock_vin_cafe_app/pages/single_food_page/single_food_page.dart';
import 'package:rock_vin_cafe_app/routes/route_helper.dart';
import 'package:rock_vin_cafe_app/utils/alert.dart';

import 'controllers/auth_controller.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final databases = Provider.of<Database>(context, listen: false);
    // auth.signOut();

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            // return LoginByPhonePage();
            return WelcomePage();
          }
          // auth.signOut();

          return FutureBuilder<UserModel>(
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
                  print(userModel.userid);
                  if (userModel.userid == "Unknown Error") {
                    return EditProfile(
                      btnName: 'Save Data',
                    );
                  }
                }
                return HomePage();
              });
          // auth.signOut();
          // return FoodCat(
          //   catgory: 1,
          // );
          // return EditProfile();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
