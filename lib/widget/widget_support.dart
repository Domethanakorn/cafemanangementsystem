import 'package:flutter/material.dart';

class AppWidget{

  static TextStyle boldTextFildStyle(){
    return TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins');
  }

  static TextStyle HeadlineTextFildStyle(){
    return TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle LightTextFildStyle(){
    return TextStyle(
        color: Colors.black38,
        fontSize: 17.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }
}