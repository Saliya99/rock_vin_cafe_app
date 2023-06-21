import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/database_controller.dart';
import 'package:rock_vin_cafe_app/models/food_model.dart';
import 'package:rock_vin_cafe_app/pages/single_food_page/single_food_page.dart';
import 'package:rock_vin_cafe_app/routes/route_helper.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';
import 'package:rock_vin_cafe_app/widgets/bottom_nav_bar.dart';
import 'package:rock_vin_cafe_app/widgets/slider/image_slider_controller.dart';

class HomePage2 extends StatefulWidget {
  @override
  State<HomePage2> createState() => _HomePage2State();
}

final Random rnd = Random();

class _HomePage2State extends State<HomePage2> {
  final Random rnd = Random();
  // int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  static const List<String> sampleImages = [
    'assets/image/food1.jpg',
    'assets/image/food2.jpg',
    'assets/image/food3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final databases = Provider.of<Database>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                color: AppColors.mainColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [
                          Text("Welcome",
                              style: GoogleFonts.pacifico(
                                fontSize: 10.w,
                                color: AppColors.titleColor,
                              )),
                          Positioned(
                            top: 50.0,
                            child: Text("Jhon Doe",
                                style: GoogleFonts.pacifico(
                                  fontSize: 5.w,
                                  color: AppColors.titleColor,
                                )),
                          )
                        ],
                      ),
                    ),
                    const Text(
                      'Janidu\nLinkeppitiya\nDambadeniya',
                      style: TextStyle(
                        color: AppColors.mainBlackColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              FanCarouselImageSliderCustom(
                turns: 500,
                slideViewportFraction: 1,
                imageRadius: 20,
                sliderHeight: 200,
                imagesLink: sampleImages,
                isAssets: true,
                autoPlay: true,
                // isClickable: false,
                currentItemShadow: [
                  BoxShadow(
                      offset: Offset(1, 1),
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 10),
                  BoxShadow(
                      offset: Offset(-1, -1),
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 10),
                ],
              ),
              FutureBuilder<List<FoodModel>>(
                future: databases.readFoodData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 100,
                      width: 100.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Loading...'),
                          SizedBox(height: 16),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('No data available');
                  } else {
                    final foodData = snapshot.data!;

                    return Expanded(
                      child: Container(
                        // height: 70.h,

                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          physics:
                              const ScrollPhysics(), // Remove NeverScrollableScrollPhysics()
                          // shrinkWrap: true, // Remove or set to false (default value)
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: foodData.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                //open single food page using navigator

                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleFoodItem(
                                              fooditem: foodData[index],
                                            )),
                                  );
                                },
                                child: FoodItemCard(foodData[index]));
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  FoodItemCard(this.foodModel, {Key? key}) : super(key: key);
  final Random rnd = Random();
  final FoodModel foodModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // radius of 10
        image: DecorationImage(
          image: AssetImage("assets/image/food${rnd.nextInt(4) + 1}.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(right: 10),
            height: 35,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              color: Colors.white.withOpacity(0.7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    foodModel.foodPrice.toString(),
                    style: TextStyle(color: AppColors.titleColor, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.white.withOpacity(0.7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    foodModel.foodName,
                    style:
                        TextStyle(color: AppColors.titleColor, fontSize: 4.w),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
