import 'package:flutter/material.dart';
Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark),
  );
}
class DateChange extends StatefulWidget {

  @override
  _DateChangeState createState() => _DateChangeState();
}

class _DateChangeState extends State<DateChange> {
  DateTime _dateTime = DateTime.now();
  void _showDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    }
    );
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:Center(
       child:Column(

         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         Text(_dateTime.toString(),style: TextStyle(fontSize: 20),),

       MaterialButton(
         onPressed: _showDatePicker,
         child: const Padding(
             padding: EdgeInsets.all(20.0),
            child:Text('Choose Date',
               style: TextStyle(color: Colors.black, fontSize: 20)),
       ),
         color: Colors.white10,
       ),


           ]
   )

     )
   );

  }

}