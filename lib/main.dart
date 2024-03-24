import 'package:flutter/material.dart';
import 'package:fluttercouse/home_screen.dart';

void main(){
  runApp(MCUAPI());
}

class MCUAPI extends StatelessWidget {
  const MCUAPI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
