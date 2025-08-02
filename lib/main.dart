import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hyphn/pages/home.dart';
import 'package:hyphn/splashscreen/splashscreen.dart';
import 'notification_service.dart'; // 👈 create this file next

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCCtseDDe8murZt2-6XxI87YprfmPWWNSk",
      authDomain: "hyphn-35bae.firebaseapp.com",
      projectId: "hyphn-35bae",
      storageBucket: "hyphn-35bae.appspot.com",
      messagingSenderId: "1050583389856",
      appId: "1:1050583389856:web:4eb13dcdbacc35f5b0dbc5",
    ),
  );

  // 🔔 Initialize Push Notification Service
  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hyphn',
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
    );
  }
}
