import 'package:flutter/material.dart';
import 'package:warehouseapp/src/views/dashboard/tracking/index.dart';

class GlobalVariable{
  static const Color mainColor = Color.fromRGBO(128, 58, 217, 1);
  static const Color buttonColor = Color.fromRGBO(87, 0, 184, 1);
  static const EdgeInsets defaultPadding = EdgeInsets.all(15);
}

enum ContactType{
  customer, vendor
}

bool shouldInitWithEncryption = false;
BarcodeFormatsRepository barcodeFormatsRepository = BarcodeFormatsRepository();