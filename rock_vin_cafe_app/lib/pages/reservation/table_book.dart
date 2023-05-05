import 'package:flutter/material.dart';

class TableBookingPage extends StatefulWidget {
  const TableBookingPage({super.key});

  @override
  _TableBookingPageState createState() => _TableBookingPageState();
}

class _TableBookingPageState extends State<TableBookingPage> {
  int selectedTable = 0;
  List<int> bookedTables = [2, 4, 7]; //assume tables 2, 4 and 7 are already booked

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Booking'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select a table to book:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTableButton(1),
                buildTableButton(2),
                buildTableButton(3),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTableButton(4),
                buildTableButton(5),
                buildTableButton(6),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTableButton(7),
                buildTableButton(8),
                buildTableButton(9),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTableButton(10),
                buildTableButton(11),
                buildTableButton(12),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTableButton(13),
                buildTableButton(14),
                buildTableButton(15),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              selectedTable == 0
                  ? 'Please select a table'
                  : 'Table $selectedTable selected',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(

              onPressed: selectedTable == 0 ? null : bookTable,
              child: Text('Book Table'),

            ),

          ],
        ),
      ),
    );
  }

  Widget buildTableButton(int tableNumber) {
    bool isBooked = bookedTables.contains(tableNumber);

    return ElevatedButton(
      onPressed: isBooked ? null : () => selectTable(tableNumber),
      child: Text('Table $tableNumber'),
      style: ElevatedButton.styleFrom(
        primary: isBooked ? Colors.grey : Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        textStyle: TextStyle(fontSize: 20.0),
      ),
    );
  }

  void selectTable(int tableNumber) {
    setState(() {
      selectedTable = tableNumber;
    });
  }

  void bookTable() {
    bookedTables.add(selectedTable);

    setState(() {
      selectedTable = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Table $selectedTable booked!'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
