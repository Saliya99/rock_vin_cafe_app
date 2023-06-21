import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/auth_controller.dart';
import 'package:rock_vin_cafe_app/landing%20_page.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';

class LoginByPhonePage extends StatefulWidget {
  const LoginByPhonePage({super.key});

  @override
  State<LoginByPhonePage> createState() => _LoginByPhonePageState();
}

class _LoginByPhonePageState extends State<LoginByPhonePage> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  String get _phone => _phoneController.text;
  bool _phoneisfilled = true;

  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  String get _otp => _otpController.text;
  bool _otpisfilled = true;

  bool isLogin = true;

  @override
  Country scountry = Country(
      phoneCode: "94",
      countryCode: "LK",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Sri Lanka",
      example: "Sri Lanka",
      displayName: "LK",
      displayNameNoCountryCode: "LK",
      e164Key: "");

  void _submit() async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+${scountry.phoneCode}${_phoneController.text.trim()}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithPhone(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Container(
                    height: 300,
                    width: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'OTP Code',
                          style: TextStyle(
                              fontSize: 7.w, color: AppColors.titleColor),
                        ),
                        textInput(_otpController, _otpFocusNode, _otpisfilled,
                            ["OTP", "Enter you OTP code"], true, false),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            height: 50.0,
                            width: 320.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColors.titleColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                    Radius.circular(50.0),
                                  ))),
                              onPressed: () async {
                                try {
                                  PhoneAuthCredential credential =
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationId,
                                          smsCode: _otpController.text.trim());
                                  final user =
                                      await auth.signInWithPhone(credential);
                                  if (user!.metadata.creationTime ==
                                      user.metadata.lastSignInTime) {
                                    print("First Timr Login");
                                  } else {
                                    // Not the first time login
                                    // Do something else
                                  }

                                  Get.offAll(() => const LandingPage());
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: const Text(
                                'Verify',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ))
                      ],
                    ),
                    // child: const Placeholder(),
                  ),
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      print("object");
    } catch (e) {
      print(e);
    }
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
              height: !isLogin ? 200 : 250,
              width: 90.w,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    width: 100.w,
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.titleColor,
                      ),
                    ),
                  ),
                  Text("Cafe",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.pacifico(
                        fontSize: isLogin ? 100 : 80,
                        color: AppColors.titleColor,
                      )),
                  Positioned(
                    top: isLogin ? 150.0 : 130.0,
                    child: Text("Rock Vin",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          fontSize: isLogin ? 50 : 30,
                          color: AppColors.titleColor,
                        )),
                  ),
                ],
              ),
            ),
            Text(isLogin ? "Login" : "Register",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: isLogin ? 50 : 30,
                  color: AppColors.titleColor,
                )),
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                textInput(
                  _phoneController,
                  _phoneFocusNode,
                  _phoneisfilled,
                  ["Phone No", "Enter you Phone No"],
                  false,
                  true,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50.0,
                  width: 320.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.titleColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ))),
                    onPressed: () {
                      _submit();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: const Text(
                      "No account ? Register",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ],
        )),
      ),
    );
  }

  SizedBox textInput(
    TextEditingController controller,
    FocusNode focusNode,
    bool isfilled,
    List<String> textlist,
    bool obscureText,
    bool isPhone,
  ) {
    return SizedBox(
      width: 80.w,
      height: 55.0,
      child: TextField(
        style: const TextStyle(
          color: AppColors.mainBlackColor,
        ),
        controller: controller,
        focusNode: focusNode,
        onTap: () {
          isfilled = false;
          setState(() {});
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: isPhone
              ? Container(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          scountry = country;
                          setState(() {});
                        },
                      );
                    },
                    child: Text(
                      "${scountry.flagEmoji} +${scountry.phoneCode}",
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                )
              : null,
          labelText: !isfilled ? textlist[1] : textlist[0],
          hintText: textlist[0],
          hintStyle: const TextStyle(
            fontSize: 15,
            color: AppColors.mainBlackColor,
          ),
          labelStyle: TextStyle(
            fontSize: 15,
            color: !isfilled ? Colors.red : AppColors.mainBlackColor,
          ),
        ),
        onChanged: (email) => _updateState(),
      ),
    );
  }

  _updateState() {
    setState(() {});
  }
}
