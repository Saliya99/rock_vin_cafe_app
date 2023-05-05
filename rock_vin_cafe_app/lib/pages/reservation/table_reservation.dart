
import 'package:rock_vin_cafe_app/pages/reservation/homedate.dart';
import 'package:rock_vin_cafe_app/pages/reservation/hompage.dart';
import 'package:rock_vin_cafe_app/pages/reservation/table%20book%202.dart';
import 'package:rock_vin_cafe_app/pages/reservation/table_book.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();

}

  class _MyHomePageState extends State<MyHomePage>{
  var  selectedType;
  final GlobalKey<FormState> _formKeyValue = GlobalKey<FormState>();
  List<String> _pnumbers = <String>[
  '1','2','3','4','5',
  ];
  bool _firstCheckboxValue = false;
  bool _secondCheckboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Container(

        decoration: BoxDecoration(

            image: DecorationImage(
                image: AssetImage("image/img1.jpg"),
                colorFilter:ColorFilter.mode(Colors.white60, BlendMode.lighten),
                fit :BoxFit.cover


                //repeat: ImageRepeat.repeatY

            )
        ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Table Reservation'),

            elevation: 12,
            backgroundColor: Colors.black,
            leading: Container(
              padding: EdgeInsets.all(5),
              child: Image.asset('image/logo.png'),
            ),

          ),
          body: Form(

              key: _formKeyValue,
              //autovalidate: true,
              child: ListView(

                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  children: <Widget>[

                    SizedBox(height: 20.0),

                    TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(
                            FontAwesomeIcons.phone,
                            color: Colors.black,
                          ),
                          hintText: 'Enter your Phone Details',
                          labelText: 'Phone',

                        ),
                        keyboardType: TextInputType.number
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.userCircle,
                          color: Colors.black,
                        ),
                        hintText: 'Enter your Name',
                        labelText: 'Name',
                      ),
                    ),

                    TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.envelope,
                          color: Colors.black,
                        ),
                        hintText: 'Enter your Email Address',
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20.0),

                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Icon(
                        //   FontAwesomeIcons.moneyBill,
                        //   size: 25.0,
                        //   color: Color(0xff11b719),
                        // ),
                        SizedBox(width: 50.0),
                        Text('Choose number of people',style:TextStyle(
                            color:Colors.black,fontSize: 20)),
                        Text('        '),
                        DropdownButton(

                          items: _pnumbers
                              .map((value) => DropdownMenuItem(
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                            value: value,
                          ))
                              .toList(),
                          onChanged: (selectedPnumbers) {
                            print('$selectedPnumbers');
                            setState(() {
                              selectedType = selectedPnumbers;
                            });
                          },
                          value: selectedType,
                          isExpanded: false,
                          hint: Text(
                            '0',
                            style: TextStyle(color: Colors.black,fontSize: 20),
                          ),
                        ),

                      ],

                    ),
                    //SizedBox(height: 40.0),
                    // StreamBuilder<QuerySnapshot>(
                    //     stream: Firestore.instance.collection("currency").snapshots(),
                    //     builder: (context, snapshot) {
                    //       if (!snapshot.hasData)
                    //         const Text("Loading.....");
                    //       else {
                    //         List<DropdownMenuItem> currencyItems = [];
                    //         for (int i = 0; i < snapshot.data.documents.length; i++) {
                    //           DocumentSnapshot snap = snapshot.data.documents[i];
                    //           currencyItems.add(
                    //             DropdownMenuItem(
                    //               child: Text(
                    //                 snap.documentID,
                    //                 style: TextStyle(color: Color(0xff11b719)),
                    //               ),
                    //               value: "${snap.documentID}",
                    //             ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              showDialog(context: context,
                                  builder: (
                                      context) => const HomePage());

                              Navigator.pushNamed(
                                  context, 'homepage');
                            },
                            color: Color(0xFFFFFFF),
                            child: const Text (
                              'Choose Time',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                //decoration: TextDecoration.underline,
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              showDialog(context: context,
                                  builder: (context) =>
                                      DateChange());

                              Navigator.pushNamed(
                                  context, 'date');
                            },
                            color: Color(0xFFFFFFF),
                            child: const Text (
                              'Choose Date',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                //decoration: TextDecoration.underline,
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                          ),
                        ]



                    ),

                    SizedBox(
                      height: 40,
                    ),


                     Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CheckboxListTile(
                            title: Text('Book outside Table',style:TextStyle(
                         color:Colors.black,fontSize: 20)),
                            value: _firstCheckboxValue,
                            onChanged: (newValue) {
                              setState(() {
                                _firstCheckboxValue = newValue!;
                                if (newValue) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TableBookingPagetwo()),
                                  );
                                }
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text('Book inside table',style:TextStyle(
                                color:Colors.black,fontSize: 20)),
                            value: _secondCheckboxValue,
                            onChanged: (newValue) {
                              setState(() {
                                _secondCheckboxValue = newValue!;
                                if (newValue) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TableBookingPage()),
                                  );
                                }
                              });
                            },
                          ),
                        ],
                      ),

                    SizedBox(
                      height: 40,
                    ),
                    // SizedBox(
                    //   height: 150.0,



                    Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: [
                          MaterialButton(
                              color: Color(0xfffffff),
                              textColor: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),


                                child: Text("  Cancle  ", style: TextStyle(fontSize: 24.0)),

                              ),
                              onPressed: () {

                              },

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),

                          MaterialButton(
                              color: Color(0xfffffff),
                              textColor: Colors.black,
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),


                                      child: Text("  Submit  ", style: TextStyle(fontSize: 24.0)),

                                  ),
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)))
                        ] )


                  ]

              )

          )

      ),

    );

  }
}
