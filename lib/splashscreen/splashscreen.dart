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
    Timer(Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/a.jpg',
          fit: BoxFit.cover, // or BoxFit.fill if you want exact screen filling
          errorBuilder: (context, error, stackTrace) {
            return Center(child: Text('Image not found!', style: TextStyle(color: Colors.red)));
          },
        ),
      ),
    );
  }
}
