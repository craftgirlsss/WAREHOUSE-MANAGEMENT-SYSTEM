import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';

Widget floatingLoading() {
  return Container(
    color: Colors.black.withOpacity(0.3),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.fourRotatingDots(
              color: Colors.white, size: 30),
          const SizedBox(height: 5),
          DefaultTextStyle(
              style: kDefaultTextStyle(), child: Text("Loading...", style: kDefaultTextStyle(color: Colors.white),))
        ],
      ),
    ),
  );
}