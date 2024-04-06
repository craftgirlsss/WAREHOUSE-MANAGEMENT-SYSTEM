import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';

AppBar kDefaultAppBar(
  BuildContext context,
  {String? title,
  bool? withAction = false,
  List<Widget>? actions
}){
  return AppBar(
    title: Text(title ?? 'Unknown', style: kDefaultTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
    backgroundColor: Colors.indigo.shade800,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_rounded,
        size: 25,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    ),
    actions: withAction == true ? actions : null
  );
}