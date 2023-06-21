import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/models/food_model.dart';
import 'package:rock_vin_cafe_app/widgets/icon_button.dart';

import '../../utils/colors.dart';

class SingleFoodItem extends StatefulWidget {
  SingleFoodItem({
    super.key,
    required this.fooditem,
  });

  final FoodModel fooditem;
  @override
  State<SingleFoodItem> createState() => _SingleFoodItemState();
}

int itemcount = 1;

class _SingleFoodItemState extends State<SingleFoodItem> {
  @override
  Widget build(BuildContext context) {
    FoodModel food = widget.fooditem;

    int itemcode = 1;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 550,
                child: Stack(
                  children: [
                    Container(
                        height: 450,
                        padding: EdgeInsets.only(
                          top: 60,
                        ),
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(20), // radius of 10
                          image: DecorationImage(
                            alignment: Alignment.bottomCenter,
                            image: AssetImage("assets/image/food1.jpg"),
                            fit: BoxFit.cover,
                          ),
                        )),
                    Positioned(
                      left: 20,
                      // right: 10,
                      top: 50,
                      width: 90.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomIconButton(
                              icon: FontAwesomeIcons.arrowLeft,
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          CustomIconButton(
                            icon: FontAwesomeIcons.shoppingCart,
                            onPressed: () {},
                          )
                          // Cart button
                        ],
                      ),
                    ),
                    Positioned(
                      top: 400,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                          child: Container(
                              padding: EdgeInsets.all(20),
                              width: 100.w,
                              height: 120.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Color.fromARGB(255, 180, 180, 180)
                                      .withOpacity(0.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        food.foodName,
                                        style: GoogleFonts.dancingScript(
                                            fontSize: 10.w,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors
                                                .buttonBackgroungColor),
                                      ),
                                      Text(
                                        "LKR " +
                                            food.foodPrice.toString() +
                                            "0",
                                        style: TextStyle(
                                            fontSize: 7.w,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.titleColor),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 100.w,
                    // height: 100,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "4.5/5.0",
                          style: TextStyle(fontSize: 6.w),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 8.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      food.foodDesc,
                      style: TextStyle(fontSize: 4.w),
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            height: 80,
            color: AppColors.titleColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          itemcount--;
                        });
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.minus,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(
                        textAlign: TextAlign.center,
                        itemcount.toString(),
                        style: TextStyle(
                          fontSize: 7.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          itemcount++;
                        });
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: AppColors.mainBlackColor,
                    border: Border.all(color: AppColors.mainBlackColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 6.w, color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
