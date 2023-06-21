import 'package:get/get.dart';
import 'package:rock_vin_cafe_app/landing%20_page.dart';
import 'package:rock_vin_cafe_app/models/food_model.dart';
import 'package:rock_vin_cafe_app/pages/auth/login_phone.dart';
import 'package:rock_vin_cafe_app/pages/cart_page/cart_page.dart';

import 'package:rock_vin_cafe_app/pages/single_food_page/single_food_page.dart';

import '../pages/auth/login_email.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String landingPage = "/landing-page";
  static const String loginbyEmailPage = "/login-by-email-page";
  static const String loginbyPhonePage = "/login-by-phone-page";

  static const String singleFoodItem = "/single-food-item";

  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';

  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';

  static String getCartPage() => '$cartPage';

  static String getLandingPage() => '$landingPage';

  static String getLoginPage() => '$loginbyEmailPage';

  static String getLoginByPhonePage() => '$loginbyPhonePage';

  static String getSingleFoodItem() => '$singleFoodItem';

  static List<GetPage> routes = [
    GetPage(
        name: singleFoodItem,
        page: () {
          return SingleFoodItem();
        }),
    GetPage(name: loginbyEmailPage, page: () => LoginByEmailPage()),
    GetPage(name: loginbyPhonePage, page: () => LoginByPhonePage()),
    GetPage(name: landingPage, page: () => LandingPage()),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn)
  ];
}
