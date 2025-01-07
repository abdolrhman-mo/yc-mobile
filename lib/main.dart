import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/auth/signup_page.dart';
import 'package:flutter_application_2/screens/home_page.dart';
import 'package:flutter_application_2/screens/timer_page.dart';

void main() {
  runApp(const MomentomApp());
}

class MomentomApp extends StatelessWidget {
  const MomentomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Steady',
      theme: ThemeData(
        fontFamily: 'Arial',
        primarySwatch: Colors.indigo,
        secondaryHeaderColor: Colors.amber,
        scaffoldBackgroundColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: const SignUpPage(),
      // home: const HomePage(),
      home: const TimerPage(),
    );
  }
}




//ده لللعب يابرو