import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';
import 'package:rock_vin_cafe_app/widgets/bottom_nav_bar.dart';

class HomePage2 extends StatefulWidget {
  @override
  State<HomePage2> createState() => _HomePage2State();
}

final Random rnd = Random();

class _HomePage2State extends State<HomePage2> {
  final Random rnd = Random();
  // int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              color: AppColors.mainColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    'Janidu\nLinkeppitiya\nDambadeniya',
                    style: TextStyle(
                      color: AppColors.mainBlackColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 100.0,
                    color: AppColors.buttonBackgroungColor,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        OfferCard(),
                        OfferCard(),
                        OfferCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return FoodItemCard();
              },
            )
                // ListView(
                //   children: [
                //     ,
                //     FoodItemCard(),
                //     FoodItemCard(),
                //   ],
                // ),
                ),
          ],
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200.0,
      margin: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            child: CachedNetworkImage(
              imageUrl:
                  'https://api.caferockvin.live/uploads/images/${1 + rnd.nextInt(20 - 1)}.jpg',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          //Text for Product name , price and description
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Food Item Name',
                  style: TextStyle(color: AppColors.titleColor),
                ),
                Text(
                  'Price',
                  style: TextStyle(color: AppColors.paraColor),
                ),
                Text(
                  'Description',
                  style: TextStyle(color: AppColors.paraColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final Random rnd = Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            'https://api.caferockvin.live/uploads/images/${1 + rnd.nextInt(20 - 1)}.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Food Item Name',
                style: TextStyle(color: AppColors.titleColor),
              ),
              Text(
                'Price',
                style: TextStyle(color: AppColors.paraColor),
              ),
              Text(
                'Description',
                style: TextStyle(color: AppColors.paraColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
