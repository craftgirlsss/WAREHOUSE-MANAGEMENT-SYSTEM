import 'package:flutter/material.dart';

TextStyle kDefaultTextStyle({
  double? fontSize = 14,
  FontWeight? fontWeight,
  Color? color = Colors.black
}) => TextStyle(
  fontFamily: "",
  color: color,
  fontWeight: fontWeight ?? FontWeight.bold,
  fontSize: fontSize,
);