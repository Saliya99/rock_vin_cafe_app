import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/auth_controller.dart';
import 'package:rock_vin_cafe_app/routes/route_helper.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';
import 'package:rock_vin_cafe_app/utils/custom_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Future<void> _googleSignIn() async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    print("Staring Google Auth");
    User? user = await auth.signInWithGoogle();

    // print(user!.metadata.creationTime);
    // print(user.metadata.lastSignInTime);
    // if (user!.metadata.creationTime == user.metadata.lastSignInTime) {
    //   print("First Timr Login");
    // } else {
    //   print("Not the first time login");
    //   // Do something else
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 250,
                  width: 250,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Text("Cafe",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.pacifico(
                            fontSize: 100,
                            color: AppColors.titleColor,
                          )),
                      Positioned(
                        top: 150.0,
                        child: Text("Rock Vin",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.kanit(
                              fontSize: 50,
                              color: AppColors.titleColor,
                            )),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    CustomIconbutton(
                      fontcolor: Color.fromARGB(255, 210, 0, 0),
                      bcolor2: AppColors.titleColor,
                      bcolor: Color.fromARGB(255, 140, 109, 102),
                      text: "Login with Email",
                      width: 80.w,
                      textStyle: GoogleFonts.aBeeZee(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                      height: 50,
                      icon: FaIcon(
                        FontAwesomeIcons.envelope,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.toNamed(RouteHelper.getLoginPage());
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomIconbutton(
                      fontcolor: Color.fromARGB(255, 210, 0, 0),
                      bcolor: AppColors.titleColor,
                      bcolor2: Color.fromARGB(255, 128, 109, 104),
                      text: "Login with Phone",
                      width: 80.w,
                      textStyle: GoogleFonts.aBeeZee(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                      height: 50,
                      icon: FaIcon(
                        FontAwesomeIcons.phone,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Get.toNamed(RouteHelper.getLoginByPhonePage());
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   height: 2,
                    //   width: 60.w,
                    //   color: Colors.black.withOpacity(0.5),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Text(
                    //   "or Login with",
                    //   style: TextStyle(fontSize: 10),
                    // ),
                    // SizedBox(
                    //   width: 100.w,
                    //   height: 80,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         child: SizedBox(
                    //           height: 40,
                    //           child: InkWell(
                    //             onTap: () {
                    //               try {
                    //                 _googleSignIn();
                    //               } catch (e) {
                    //                 print(e);
                    //               }
                    //             },
                    //             child: Image.network(
                    //               "https://img.icons8.com/color/48/google-logo.png",
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 20,
                    //       ),
                    //       Container(
                    //         child: Image.network(
                    //             "https://img.icons8.com/color/48/facebook-new.png"),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
