import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/auth_controller.dart';
import 'package:rock_vin_cafe_app/controllers/recommended_product_controller.dart';
import 'package:rock_vin_cafe_app/pages/cart/cart_page.dart';
import 'package:rock_vin_cafe_app/pages/food/popular_food_detail.dart';
import 'package:rock_vin_cafe_app/pages/food/recommended_food_detail.dart';
import 'package:rock_vin_cafe_app/pages/home/main_food_page.dart';
import 'package:rock_vin_cafe_app/routes/route_helper.dart';
import 'controllers/popular_product_controller.dart';
import 'package:rock_vin_cafe_app/pages/home/food_page_body.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Provider<AuthBase>(
        create: (context) => Auth(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'RockVin Cafe',
          //home: MainFoodPage(),
          initialRoute: RouteHelper.getLandingPage(),
          getPages: RouteHelper.routes,
        ),
      );
    });
  }
}
