import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Workshop',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        accentColor: Colors.white,
        backgroundColor: const Color(0xFFEEEEEE),
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
