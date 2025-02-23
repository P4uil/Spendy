import 'package:flutter/material.dart';
import 'views/home.dart';

void main() {
  runApp(SpendyApp());
}

class SpendyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
