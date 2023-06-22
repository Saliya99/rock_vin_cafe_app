import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rock_vin_cafe_app/controllers/auth_controller.dart';
import 'package:rock_vin_cafe_app/controllers/database_controller.dart';
import 'package:rock_vin_cafe_app/models/card_colums.dart';
import 'package:rock_vin_cafe_app/models/cart_model.dart';
import 'package:rock_vin_cafe_app/utils/colors.dart';
import 'package:rock_vin_cafe_app/widgets/icon_button.dart';

class CardDetailsPage extends StatefulWidget {
  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

List<CardModel> cardmodel = [];

class _CardDetailsPageState extends State<CardDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();

  Future<void> _submitCardDetails() async {
    final databases = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);
    print("object");
    // Access the validated form field values
    String name = _nameController.text;
    String cardNumber = _cardNumberController.text;
    String cvv = _cvvController.text;
    String expiryDate = _expiryDateController.text;

    try {
      CardModel cardModel = CardModel(
          cardId: 0,
          nameOnCard: name,
          cardNo: (cardNumber),
          csvNo: int.parse(cardNumber),
          exp: (expiryDate),
          username: auth.currentUser!.uid);
      print(cardModel.tableColumnsoutid());
      await databases.saveCardData("card_table", cardModel.tableColumnsoutid(),
          cardModel.dataToListoutid());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final databases = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                        icon: FontAwesomeIcons.arrowLeft,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Text(
                      "Card",
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
              SizedBox(
                height: 300,
                child: FutureBuilder<List<CardModel>>(
                    future: databases.readCardData(auth.currentUser!.uid),
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
                        cardmodel = snapshot.data!;
                        return Container(
                          height: 65.h,
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                          child: ListView.builder(
                            physics:
                                const ScrollPhysics(), // Remove NeverScrollableScrollPhysics()
                            // shrinkWrap: true, // Remove or set to false (default value)
                            itemCount: cardmodel.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: CardDetails(cardmodel[index]),
                              );
                            },
                          ),
                        );
                      }
                    }),
              ),
              SizedBox(
                width: 90.w,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration:
                              InputDecoration(labelText: 'Name on Card'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _cardNumberController,
                          decoration: InputDecoration(labelText: 'Card Number'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a card number';
                            }
                            // Perform additional card number validation if needed
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _cvvController,
                          decoration: InputDecoration(labelText: 'CVV'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a CVV number';
                            }
                            // Perform additional CVV validation if needed
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _expiryDateController,
                          decoration:
                              InputDecoration(labelText: 'Expiration Date'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an expiration date';
                            }
                            // Perform additional expiration date validation if needed
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            // _addToCart(int.parse(food.foodId), itemcount,
                            //     food.foodPrice);
                            // addOrder();
                            if (_formKey.currentState!.validate()) {
                              // Form fields passed validation, submit the data
                              _submitCardDetails();
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(0.5.w),
                            alignment: Alignment.center,
                            height: 40,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color: AppColors.mainBlackColor,
                              border:
                                  Border.all(color: AppColors.mainBlackColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Add the Card',
                              style: TextStyle(
                                fontSize: 4.5.w,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container CardDetails(CardModel cardmodel) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: 80.w,
      height: 70,
      //add show and a border to container,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 5,
            // offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(cardmodel.nameOnCard),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${cardmodel.cardNo}"),
              Text("${cardmodel.csvNo}"),
              Text("${cardmodel.exp}"),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cardNumberController.dispose();
    _cvvController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }
}
