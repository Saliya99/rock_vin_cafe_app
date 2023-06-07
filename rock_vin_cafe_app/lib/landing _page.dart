import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:rock_vin_cafe_app/controllers/database_controller.dart';
import 'package:rock_vin_cafe_app/pages/auth/login_email.dart';
import 'package:rock_vin_cafe_app/pages/auth/login_phone.dart';
import 'package:rock_vin_cafe_app/pages/auth/welocme.dart';
import 'package:rock_vin_cafe_app/pages/home/home.dart';
import 'package:rock_vin_cafe_app/pages/home/home_page_2.dart';
import 'package:rock_vin_cafe_app/pages/profile/profile.dart';
import 'package:rock_vin_cafe_app/routes/route_helper.dart';

import 'controllers/auth_controller.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            // return LoginByPhonePage();
            return WelcomePage();
          }
          //return HomePage();
          // auth.signOut();
          return Provider<Database>(
            create: (context) => SQLDatabase(),
            child: HomePage(),
          );
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
