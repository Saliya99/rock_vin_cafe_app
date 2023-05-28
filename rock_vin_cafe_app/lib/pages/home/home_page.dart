import 'package:flutter/material.dart';
import 'package:rock_vin_cafe_app/pages/home/main_food_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,),
               // title:Text("home")
          )
        ],


      )

    );
  }
}

