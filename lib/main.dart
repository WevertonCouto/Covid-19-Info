import 'package:covid_19/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: const Color(0xFFf44336),
        accentColor: const Color(0xFFf44336),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: HomeScreen(title: 'Covid-19 Info'),
    );
  }
}