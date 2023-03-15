import 'package:RockVin/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _signout() {
    //connect Class Auth from app/servises/auth.dart using provider create in main.dart
    final auth = Provider.of<AuthBase>(context, listen: false);
    auth.signOut(); //call for signout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 50.0,
          width: 320.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ))),
            onPressed: _signout,
            child: Text(
              'Signout',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
