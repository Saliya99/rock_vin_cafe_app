import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/auth_controller.dart';
import 'package:rock_vin_cafe_app/controllers/database_controller.dart';
import 'package:rock_vin_cafe_app/routes/route_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MultiProvider(
        providers: [
          Provider<AuthBase>(
            create: (context) => Auth(),
          ),
          Provider<Database>(
            create: (context) => SQLDatabase(),
          ),
        ],
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
