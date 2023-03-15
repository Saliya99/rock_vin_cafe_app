import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  Void initState() {
    super.initState()();
    controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  // controller =
  //     AnimationController(vsync: this, duration: const Duration(seconds: 2));
  // animation = CurvedAnimation(parent: controller, curve: Curves.linear);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Image.asset(
          "assets/image/logopart1.png",
          width: 250,
        )
      ]),
    );
  }
}
