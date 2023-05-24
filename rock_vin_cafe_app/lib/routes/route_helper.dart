import 'package:get/get.dart';
import 'package:rock_vin_cafe_app/pages/food/popular_food_detail.dart';
import 'package:rock_vin_cafe_app/pages/food/recommended_food_detail.dart';
import 'package:rock_vin_cafe_app/pages/home/main_food_page.dart';

class RouteHelper{
  static const String initial="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";

  static String getInitial()=>'$initial';
  static String getPopularFood()=>'$popularFood';
  static String getrecommendedFood()=>'$recommendedFood';
  static List<GetPage> routes=[
    GetPage(name: initial, page: ()=>MainFoodPage()),

    GetPage(name: popularFood, page: (){
      return PopularFoodDetail();
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: recommendedFood, page: (){
      return RecommendedFoodDetails();
    },
        transition: Transition.fadeIn
    )
  ];
}