import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';
import 'package:rock_vin_cafe_app/home/food_page_body.dart';
import 'package:rock_vin_cafe_app/widgets/big_text.dart';
import 'package:rock_vin_cafe_app/widgets/small_text.dart';

//import 'package:flutter/src/widgets/placeholder.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPage();
}

class _MainFoodPage extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ////////////////////////////showing the header///////////////////////
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 45, bottom: 15),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "Sri Lanka", color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(
                            text: "Midigama",
                            color: Colors.black54,
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      child: Icon(Icons.search, color: Colors.white),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ///////////////////////////showing the body/////////////////////////
          FoodPageBody(),
        ],
      ),
    );
  }
}
