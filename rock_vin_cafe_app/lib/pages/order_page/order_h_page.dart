import 'dart:math';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/auth_controller.dart';
import 'package:rock_vin_cafe_app/controllers/database_controller.dart';
import 'package:rock_vin_cafe_app/models/cart_model.dart';
import 'package:rock_vin_cafe_app/models/order_h_model.dart';
import 'package:rock_vin_cafe_app/models/order_model.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';
import 'package:rock_vin_cafe_app/widgets/icon_button.dart';

class OrderHPage extends StatefulWidget {
  const OrderHPage({super.key});

  @override
  State<OrderHPage> createState() => _OrderHPageState();
}

int itemcount = 1;
bool isbtnclicked = false;
final Random rnd = Random();
List<OrderHModel> cartmodel = [];

class _OrderHPageState extends State<OrderHPage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final databases = Provider.of<Database>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CustomIconButton(
                    //     icon: FontAwesomeIcons.arrowLeft,
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     }),
                    Text(
                      "Order History",
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
                    // CustomIconButton(
                    //     icon: FontAwesomeIcons.home,
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     }),
                  ],
                ),
              ),
              //FutureBuilder for get data from sql
              Expanded(
                child: FutureBuilder<List<OrderHModel>>(
                  future: databases.readOrderData(auth.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 100,
                        width: 100.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text('Loading...'),
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
                      cartmodel = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 73.h,
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: ListView.builder(
                                  physics:
                                      const ScrollPhysics(), // Remove NeverScrollableScrollPhysics()
                                  // shrinkWrap: true, // Remove or set to false (default value)
                                  itemCount: cartmodel.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: CartItem(cartmodel[index]),
                                    );
                                  },
                                ),
                              )),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container CartItem(OrderHModel cartModel) {
    IconData sttsicon;
    if (cartModel.status == '2') {
      sttsicon = FontAwesomeIcons.circleCheck;
    } else if (cartModel.status == '1') {
      sttsicon = FontAwesomeIcons.kitchenSet;
    } else {
      sttsicon = FontAwesomeIcons.clockRotateLeft;
    }
    return Container(
      width: 95.w,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // radius of 10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 90,
                width: 35.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // radius of 10

                  image: DecorationImage(
                    image: AssetImage("assets/image/${cartModel.foodImg}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      // padding: const EdgeInsets.only(top: 00),
                      width: 55.w,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        cartModel.foodName.toString(),
                        style: TextStyle(fontSize: 5.w),
                      ),
                    ),
                    SizedBox(
                      width: 50.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${cartModel.foodPrice}0   X${cartModel.quantity}",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text("RS ${cartModel.totalPrice}.00",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          // FaIcon(FontAwesomeIcons.kitchenSet),
                          FaIcon(sttsicon),
                          // FaIcon(FontAwesomeIcons.clockRotateLeft),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          //for quantity and total price
        ],
      ),
    );
  }
}
