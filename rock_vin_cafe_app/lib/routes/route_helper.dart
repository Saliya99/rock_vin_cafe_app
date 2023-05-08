import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rock_vin_cafe_app/pages/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash_page";

  static String getSplashPage() => '$splashPage';
}

State List<GetPage> routes=[
  GetPage(name: splashPage, page: () => SplashScreen());

]
