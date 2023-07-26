import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/auth_controller.dart';
import 'package:rock_vin_cafe_app/controllers/database_controller.dart';
import 'package:rock_vin_cafe_app/models/food_model.dart';
import 'package:rock_vin_cafe_app/models/user_model.dart';
import 'package:rock_vin_cafe_app/pages/single_food_page/single_food_page.dart';
import 'package:rock_vin_cafe_app/routes/route_helper.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';
import 'package:rock_vin_cafe_app/widgets/bottom_nav_bar.dart';
import 'package:rock_vin_cafe_app/widgets/icon_button.dart';
import 'package:rock_vin_cafe_app/widgets/slider/image_slider_controller.dart';

class FoodCat extends StatefulWidget {
  const FoodCat({super.key, required this.catgory, required this.catgoryname});

  @override
  State<FoodCat> createState() => _FoodCatState();

  final int catgory;
  final String catgoryname;
}

final Random rnd = Random();

class _FoodCatState extends State<FoodCat> {
  final Random rnd = Random();
  // int _page = 0;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final databases = Provider.of<Database>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                        icon: FontAwesomeIcons.arrowLeft,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Text(
                      "${widget.catgoryname}",
                      style: GoogleFonts.pacifico(
                        fontSize: 10.w,
                        color: AppColors.titleColor,
                        shadows: [
                          Shadow(
                            blurRadius: 100.0,
                            color: Color.fromARGB(50, 0, 0, 0),
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                    ),
                    CustomIconButton(
                        icon: FontAwesomeIcons.home,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
              FutureBuilder<List<FoodModel>>(
                future: databases
                    .readFoodData('WHERE food_cat_id = ${widget.catgory}'),
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
                                  //get.tonamed
                                  Get.toNamed('/single-food-item',
                                      arguments: foodData[index]);

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => SingleFoodItem(
                                  //             fooditem: foodData[index],
                                  //           )),
                                  // // );
                                  // RouteHelper.routerHelper.goToPage(
                                  //     SingleFoodItem(fooditem: foodData[index]));
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
    // print("assets/image/${foodModel.foodImg}");
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // radius of 10
        image: DecorationImage(
          image: AssetImage("assets/image/${foodModel.foodImg}"),
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
                    'RS. ${foodModel.foodPrice}0',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
