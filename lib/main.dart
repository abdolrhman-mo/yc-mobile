import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/auth/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MomentomApp());
}

class MomentomApp extends StatelessWidget {
  const MomentomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Momentom',
      theme: ThemeData(
        fontFamily: 'Arial',
        primarySwatch: Colors.indigo,
        secondaryHeaderColor: Colors.amber,
        scaffoldBackgroundColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
    );
  }
}




//ده لللعب يابرو