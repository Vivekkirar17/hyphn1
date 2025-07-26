import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hyphn/pages/home.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => SplashscreenState();
}

class SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'a.jpeg', // Your splash image path
          width: 2000,
          height: 1000,
            fit: BoxFit.contain,
        ),
      ),
    );
  }
}