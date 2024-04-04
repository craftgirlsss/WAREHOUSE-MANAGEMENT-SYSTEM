import 'package:flutter/material.dart';

Container backgroundColor(context){
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.indigo.shade800,
          Colors.indigo.shade700,
          Colors.indigo.shade600,
          Colors.indigo.shade400,
        ],
      )
    ),
  );
}