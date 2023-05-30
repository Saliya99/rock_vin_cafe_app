import 'package:flutter/material.dart';
import 'package:rock_vin_cafe_app/pages/home/main_food_page.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int _selectedIndex=0;

  List pages=[

    MainFoodPage(),
    Container(child: Center(child: Text("NextPage "))),
    Container(child: Center(child: Text("Next next page "))),
    Container(child: Center(child: Text("Next next next page "))),

  ];
  onTapNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,),
              label:("home")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive,),
            label:("history")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,),
            label:("cart")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,),
            label:("me")
          ),
        ],
      )
    );
  }
}