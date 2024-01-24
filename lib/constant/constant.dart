import 'package:flutter/material.dart';

const primaryColor = Color(0xFFFFC107);
const secondaryColor = Color(0xFF242430);
const darkColor = Color(0xFF191923);
const bodyTextColor = Color(0xFF8B8B8D);
const bgColor = Color(0xFF26283D);
const whiteColor = Colors.white;
const kButtonColorBlue = Colors.blue;
const scaffoldBgColor = Color(0xFF1A1C31);
const colorGrey = Colors.grey;
const primaryColor2 = Colors.greenAccent;
const green = Color.fromARGB(255, 24, 237, 134);
//color
const defaultPadding = 20.0;
const defaultDuration = Duration(seconds: 2); // we use it on our animation
const maxWidth = 1339.0; // max width of our web

const kHeight = SizedBox(
  height: 20,
);

var mHeight;
var mWidth;

const scaffoldGradient = LinearGradient(
  colors: [scaffoldBgColor, scaffoldBgColor],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.0, 10.0],
  tileMode: TileMode.clamp,
);
