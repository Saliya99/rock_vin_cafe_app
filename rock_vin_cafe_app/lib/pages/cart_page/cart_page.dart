import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/auth_controller.dart';
import 'package:rock_vin_cafe_app/controllers/database_controller.dart';
import 'package:rock_vin_cafe_app/models/cart_model.dart';
import 'package:rock_vin_cafe_app/pages/order_page/order_page.dart';
import 'package:rock_vin_cafe_app/routes/route_helper.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  final args = Get.arguments;
  @override
  State<CartPage> createState() => _CartPageState();
}

int itemcount = 1;
bool isbtnclicked = false;
final Random rnd = Random();
List<CartModel> cartmodel = [];

class _CartPageState extends State<CartPage> {
  Future<void> _cartq(int cartid, int count, int foodId) async {
    print(count);
    final databases = Provider.of<Database>(context, listen: false);
    await databases.updateCartQ(cartid, count, foodId);
    setState(() {});
  }

  Future<void> _cartDel(int cartid) async {
    final databases = Provider.of<Database>(context, listen: false);
    await databases.deleteCartQ(cartid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final databases = Provider.of<Database>(context, listen: false);
    print(widget.args);
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.args == "singlefoodpage"
                      ? IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.titleColor,
                          ),
                        )
                      : SizedBox(),
                  Text(
                    "Cart",
                    style: GoogleFonts.pacifico(
                      fontSize: 10.w,
                      color: AppColors.titleColor,
                    ),
                  ),
                  widget.args == "singlefoodpage"
                      ? SizedBox(
                          width: 50,
                        )
                      : SizedBox()
                ],
              ),
              //FutureBuilder for get data from sql
              FutureBuilder<List<CartModel>>(
                future: databases.readCartData(auth.currentUser!.uid),
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
                    cartmodel = snapshot.data!;

                    return Column(
                      children: [
                        Container(
                          height: widget.args == "singlefoodpage" ? 72.h : 65.h,
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
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
                        ),
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          height: 75,
                          // color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Items x${cartmodel.fold(0, (sum, item) => sum + item.quantity)}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.mainBlackColor,
                                    ),
                                  ),
                                  Text(
                                    "Total RS ${cartmodel.fold(0.0, (sum, item) => sum + item.totalPrice)}0",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: AppColors.mainBlackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  if (cartmodel.isEmpty) {
                                    print("object");
                                    return null;
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrderPage()));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(0.5.w),
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 35.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainBlackColor,
                                    border: Border.all(
                                        color: AppColors.mainBlackColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Order Now',
                                    style: TextStyle(
                                        fontSize: 4.5.w, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
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

  Container CartItem(CartModel cartModel) {
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
                      width: 55.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            // padding: const EdgeInsets.only(top: 00),
                            width: 30.w,
                            child: Text(
                              cartModel.foodName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 5.w),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                _cartDel(cartModel.cartId);
                              },
                              child: FaIcon(
                                FontAwesomeIcons.trashAlt,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                    Text(
                      "RS ${cartModel.foodPrice}0   X${cartModel.quantity}",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 55.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: 30,
                                child: IconButton(
                                  onPressed: () {
                                    if (cartModel.quantity == 1) {
                                      _cartDel(cartModel.cartId);
                                    } else {
                                      _cartq(cartModel.cartId, -1,
                                          cartModel.foodId);
                                    }
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.minus,
                                    color: Colors.black,
                                    size: 12,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  cartModel.quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 5.w,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                                width: 30,
                                child: IconButton(
                                  onPressed: () {
                                    _cartq(
                                        cartModel.cartId, 1, cartModel.foodId);
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.add,
                                    color: Colors.black,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text("RS ${cartModel.totalPrice}0",
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
