import 'package:flutter/material.dart';
import 'package:fruitsmarket/component.dart';

class Screen extends StatefulWidget {
  static String id = 'LoginScreen';
  State<StatefulWidget> createState() {
    return ScreenState();
  }
}

class ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColors,
      body: Container(),
    );
  }
}
