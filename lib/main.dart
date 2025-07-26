import 'package:flutter/material.dart';
import 'package:hyphn/pages/home.dart';
import 'package:hyphn/splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hyphn',
     initialRoute:'/' ,
     routes: {
      '/': (context)=> const Splashscreen(),
      '/home': (context)=> const Home(),
     }, 
     
    
    );
  }
}


