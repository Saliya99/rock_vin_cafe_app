import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/database_controller.dart';
import 'package:rock_vin_cafe_app/models/food_cat.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

List<String> _foodlist = [
  'apple',
  'banana',
  'orange',
  'grapes',
  'watermelon',
  'kiwi',
  'peach',
  'pear',
  'pineapple',
  'strawberry'
];

class _SearchPageState extends State<SearchPage> {
  final _popupCustomValidationKey = GlobalKey<DropdownSearchState<int>>();
  TextEditingController _searchController = TextEditingController();
  List<String> _filteredFoodList =
      _foodlist; // New list variable for filtered items

  @override
  Widget build(BuildContext context) {
    final databases = Provider.of<Database>(context, listen: false);

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              onChanged: (a) {
                String query = _searchController.text.toLowerCase();
                // Filter the _foodlist based on the query
                _filteredFoodList = _foodlist
                    .where((item) => item.toLowerCase().contains(query))
                    .toList();
                // Trigger a rebuild of the widget
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Enter your search query',
              ),
            ),
            SizedBox(height: 16.0),

            SizedBox(height: 16.0),
            //
            // print the list
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: _filteredFoodList.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text(_filteredFoodList[index]),
            //       );
            //     },
            //   ),
            // ),
            FutureBuilder<List<CategoryModel>>(
              future: databases.foodList(),
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
                          return FoodItemCard(foodData[index]);
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
    ));
  }
}

class FoodItemCard extends StatelessWidget {
  FoodItemCard(this.category, {Key? key}) : super(key: key);
  final Random rnd = Random();
  final CategoryModel category;
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
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
                    category.cateName,
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
