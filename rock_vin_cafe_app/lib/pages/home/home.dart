import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_vin_cafe_app/pages/cart/cart_page.dart';
import 'package:rock_vin_cafe_app/pages/home/home_page_2.dart';
import 'package:rock_vin_cafe_app/pages/profile/profile.dart';
import 'package:rock_vin_cafe_app/pages/search_page/search_page.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? index;
  @override
  void initState() {
    index = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.shopping_cart, title: "Cart"),
          TabItem(icon: Icons.search, title: "Search"),
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.where_to_vote, title: "Track"),
          TabItem(icon: Icons.person, title: "Profile"),
        ],
        color: AppColors.mainBlackColor,
        activeColor: AppColors.mainColor,
        backgroundColor: Colors.white,
        style: TabStyle.fixedCircle,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
        initialActiveIndex: 2,
        elevation: 2,
        // height: 45,
      ),
      body: Builder(
        builder: (BuildContext context) {
          switch (index) {
            case 0:
              return CartPage();

            case 1:
              return SearchPage();

            case 2:
              return HomePage2();

            case 3:
              return Container(
                color: Colors.green,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text("Message"),
              );

            case 4:
              return ProfileViewPage();

            default:
              return Container();
          }
        },
      ),
    );
  }
}
