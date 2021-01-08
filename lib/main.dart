import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ridepool/Screens/Register.dart';
import 'package:ridepool/Screens/StartupScreen.dart';
import 'package:ridepool/Screens/configureScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartupScreen(),//splashscreen
    );
  }
}

