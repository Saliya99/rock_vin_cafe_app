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
import 'package:rock_vin_cafe_app/models/order_model.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';
import 'package:rock_vin_cafe_app/widgets/icon_button.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

int itemcount = 1;
bool isbtnclicked = false;
final Random rnd = Random();
List<CartModel> cartmodel = [];

class _OrderPageState extends State<OrderPage> {
  Future<void> addOrder() async {
    final databases = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);

//loop for list of cartmodel
    for (int i = 0; i < cartmodel.length; i++) {
      OrderModel orderModel = OrderModel(
        uid: auth.currentUser!.uid,
        foodId: cartmodel[i].foodId,
        quantity: cartmodel[i].quantity,
        totalPrice: cartmodel[i].totalPrice,
        status: 0,
        pickupTime: DateTime.parse(formattedDateTime),
        orderFrom: 'm',
      );
      await databases.addOrder(orderModel);
    }

    OrderModel orderModel = OrderModel(
      uid: auth.currentUser!.uid,
      foodId: cartmodel[0].foodId,
      quantity: cartmodel.fold(0, (sum, item) => sum + item.quantity),
      totalPrice: cartmodel.fold(0.0, (sum, item) => sum + item.totalPrice),
      status: 0,
      pickupTime: DateTime.parse(formattedDateTime),
      orderFrom: 'm',
    );
    // await databases.deleteCartQ();
  }

  Future<void> _cartq(int cartid, int count) async {
    final databases = Provider.of<Database>(context, listen: false);
    await databases.updateCartQ(cartid, count);
    setState(() {});
  }

  Future<void> _cartDel(int cartid) async {
    final databases = Provider.of<Database>(context, listen: false);
    await databases.deleteCartQ(cartid);
    setState(() {});
  }

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String formattedDateTime = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedDate != null) {
      _selectedDate = pickedDate;
    }
    if (pickedTime != null) {
      _selectedTime = pickedTime;
    }
    if (_selectedDate != null && _selectedTime != null) {
      final String formattedDate =
          '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';
      final String formattedTime =
          '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00';
      formattedDateTime = '$formattedDate $formattedTime';
    }
    setState(() {});
  }

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                        icon: FontAwesomeIcons.arrowLeft,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Text(
                      "Cart",
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
              //FutureBuilder for get data from sql
              Expanded(
                child: FutureBuilder<List<CartModel>>(
                  future: databases.readCartData(auth.currentUser!.uid),
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
                              height: 65.h,
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
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            height: 120,
                            // color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      child: Text(
                                        formattedDateTime == ""
                                            ? "Select the Time"
                                            : formattedDateTime,
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: AppColors.mainBlackColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    InkWell(
                                      onTap: () => _selectDate(context),
                                      child: FaIcon(
                                        FontAwesomeIcons.clock,
                                        color: AppColors.mainBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Items x${cartmodel.fold(0, (sum, item) => sum + item.quantity)}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.mainBlackColor,
                                          ),
                                        ),
                                        Text(
                                          "Total ${cartmodel.fold(0.0, (sum, item) => sum + item.totalPrice)}0",
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
                                        // _addToCart(int.parse(food.foodId), itemcount,
                                        //     food.foodPrice);
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          'Buy Now',
                                          style: TextStyle(
                                            fontSize: 4.5.w,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
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
                    image: AssetImage(
                        "assets/image/food${rnd.nextInt(4) + 1}.jpg"),
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
                      // width: 30.w,
                      child: Text(
                        cartModel.foodName,
                        style: TextStyle(fontSize: 5.w),
                      ),
                    ),
                    Text(
                      "${cartModel.foodPrice}0   X${cartModel.quantity}",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text("${cartModel.totalPrice}0",
                        style: TextStyle(fontSize: 20)),
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
