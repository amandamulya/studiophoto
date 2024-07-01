// lib/main.dart
import 'package:flutter/material.dart';
import 'package:studiophoto/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studio Photo',
      theme: ThemeData(
        primarySwatch: Colors.brown, // Change to coffee color
      ),
      home: LoginScreen(),
    );
  }
}
