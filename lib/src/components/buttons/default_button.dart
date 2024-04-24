import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';

ElevatedButton kDeafultButton({
  String? title,
  Function()? onPressed,
  Color? textColor,
  FontWeight? fontWeight,
  double? fontSize,
  Color? backgroundColor = const Color.fromRGBO(128, 58, 217, 1)
}) => ElevatedButton(
  onPressed: onPressed, 
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15)
    ),
    backgroundColor: backgroundColor,
  ),
  child: Text(title ?? 'Submit', style: kDefaultTextStyle(fontSize: fontSize ?? 18, color: textColor ?? Colors.white, fontWeight: fontWeight ?? FontWeight.bold),));