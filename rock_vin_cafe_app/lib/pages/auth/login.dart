import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/auth_controller.dart';
import 'package:rock_vin_cafe_app/controllers/database_controller.dart';
import 'package:rock_vin_cafe_app/landing%20_page.dart';
import 'package:rock_vin_cafe_app/models/user_model.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  String get _email => _emailController.text;
  bool _emailisfilled = true;

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  String get _password => _passwordController.text;
  bool _passwordisfilled = true;

  final TextEditingController _fnameController = TextEditingController();
  final FocusNode _fnameFocusNode = FocusNode();
  String get _fname => _fnameController.text;
  bool _fnameisfilled = true;

  final TextEditingController _lnameController = TextEditingController();
  final FocusNode _lnameFocusNode = FocusNode();
  String get _lname => _lnameController.text;
  bool _lnameisfilled = true;

  final TextEditingController _addressController = TextEditingController();
  final FocusNode _addressFocusNode = FocusNode();
  String get _address => _addressController.text;
  bool _addressisfilled = true;

  final TextEditingController _cityController = TextEditingController();
  final FocusNode _cityFocusNode = FocusNode();
  String get _city => _cityController.text;
  bool _cityisfilled = true;

  bool isLogin = false;

  void _submit() async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);

      // send email and password to createUserWithEmailandPassword in auth.dart for register
      User? user =
          await auth.createAccountWithEmailAndPassword(_email, _password);

      if (user != null) {
        Database database = new SQLDatabase();
        var conn = await database.getDbConnection();

        await conn.connect();

        UserModel userModel = UserModel(
          userId: user.uid,
          phoneNumber: 1231231234,
          address: _address,
          city: _city,
          firstName: _fname,
          lastName: _lname,
          email: _email,
        );

        database.saveData(
            "users", userModel.tableColumns(), userModel.dataToList());
      }
    } catch (e) {
      print("Can't connect to database");
      print(e);
    }
    // try {
    //   //connect Class Auth from app/servises/auth.dart using provider create in main.dart
    //   final auth = Provider.of<AuthBase>(context, listen: false);

    //   // send email and password to createUserWithEmailandPassword in auth.dart for register
    //   User? user =
    //       await auth.createAccountWithEmailAndPassword(_email, _password);
    //   if (user != null) {
    //     print(user.uid);
    //   }
    // } catch (e) {
    //   print(e.toString());
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
            Column(
              children: [
                Text(isLogin ? "Login" : "Register",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: isLogin ? 50 : 30,
                      color: AppColors.titleColor,
                    )),
                const SizedBox(
                  height: 10,
                ),
                textInput(
                  _emailController,
                  _emailFocusNode,
                  _emailisfilled,
                  ["Email", "Enter you Email"],
                  false,
                ),
                textInput(
                  _passwordController,
                  _passwordFocusNode,
                  _passwordisfilled,
                  ["Password", "Enter you Password"],
                  true,
                ),
                !isLogin
                    ? textInput(
                        _fnameController,
                        _fnameFocusNode,
                        _fnameisfilled,
                        ["First Name", "Enter you First Name"],
                        false,
                      )
                    : SizedBox(),
                !isLogin
                    ? textInput(
                        _lnameController,
                        _lnameFocusNode,
                        _lnameisfilled,
                        ["Last Name", "Enter you Last Name"],
                        false,
                      )
                    : SizedBox(),
                !isLogin
                    ? textInput(
                        _addressController,
                        _addressFocusNode,
                        _addressisfilled,
                        ["Address", "Enter you Address"],
                        false,
                      )
                    : SizedBox(),
                !isLogin
                    ? textInput(
                        _cityController,
                        _cityFocusNode,
                        _cityisfilled,
                        ["City", "Enter you City"],
                        false,
                      )
                    : SizedBox(),
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
