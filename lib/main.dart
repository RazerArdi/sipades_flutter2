import 'package:flutter/material.dart';
import 'package:sipades_flutter2/AnimatedSplashScreenPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIPADES',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreenPage(),
    );
  }
}