import 'package:flutter/material.dart';
import 'package:raon/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RaonTube',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
        color: Colors.black),
        scaffoldBackgroundColor:Colors.black,
      ),
      home: HomeScreen(),
    );
  }
}