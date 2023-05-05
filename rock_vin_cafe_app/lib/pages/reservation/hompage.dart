

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // create TimeOfDay variable
  TimeOfDay _timeOfDay = TimeOfDay.now();

  // show time picker method
  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // display the chosen time
            Text(
              _timeOfDay.format(context).toString(), style: TextStyle(fontSize: 20),
            ),

            // button
            MaterialButton(
              onPressed: _showTimePicker,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Pick Time',

                    style: TextStyle(color: Colors.black, fontSize: 20)),

              ),
              color: Colors.white10,
            ),
          ],
        ),
      ),
    );
  }
}

