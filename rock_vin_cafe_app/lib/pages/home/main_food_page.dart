import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';
import 'package:rock_vin_cafe_app/pages/home/food_page_body.dart';
import 'package:rock_vin_cafe_app/utils/dimensions.dart';
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
              margin: EdgeInsets.only(
                  top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
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
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(Icons.search,
                          color: Colors.white, size: Dimensions.iconSize24),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ///////////////////////////showing the body/////////////////////////
          Expanded(
              child: SingleChildScrollView(
            child: FoodPageBody(),
          )),
        ],
      ),
    );
  }
}
