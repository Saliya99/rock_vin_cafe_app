// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElebutton extends StatelessWidget {
  const CustomElebutton({
    required this.color,
    this.onPressed,
    required this.fontcolor,
    required this.bcolor,
    required this.bcolor2,
    required this.text,
    required this.width,
    required this.textStyle,
    required this.height,
  });

  final Color color; //OK
  final Color bcolor; //OK
  final Color bcolor2; //OK
  final String text;
  final Color fontcolor;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
              spreadRadius: 0.2,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(colors: [
            bcolor,
            bcolor2,
          ]),
          borderRadius: BorderRadius.circular(30),
        ),
        height: height,
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ))),
          onPressed: onPressed,
          child: Text(text, style: textStyle),
        ),
      ),
    );
  }
}

class CustomIconbutton extends StatelessWidget {
  const CustomIconbutton({
    // required this.color,
    this.onPressed,
    required this.fontcolor,
    required this.bcolor,
    required this.bcolor2,
    required this.text,
    required this.width,
    required this.textStyle,
    required this.height,
    required this.icon,
  });

  // final Color color; //OK
  final Color bcolor; //OK
  final Color bcolor2; //OK
  final String text;
  final Color fontcolor;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final TextStyle textStyle;
  final FaIcon icon;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
              spreadRadius: 0.2,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(colors: [
            bcolor,
            bcolor2,
          ]),
          borderRadius: BorderRadius.circular(30),
        ),
        height: height,
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              SizedBox(
                width: width / 10,
              ),
              Text(
                text,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
