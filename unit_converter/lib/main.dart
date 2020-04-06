import 'package:flutter/material.dart';
import 'category_route.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit _Converter', 
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent[200],
        fontFamily: 'Georgia',
        textTheme:TextTheme(
          headline: TextStyle(fontSize: 0.72),
          body1: TextStyle(fontSize: 0.42))
      ),
      home: CategoryRoute(),
    );
  }
}