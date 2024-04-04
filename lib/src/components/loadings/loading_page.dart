import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/views/mainpage.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), (){
      Get.to(() => const MainPage());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backgroundColor(context),
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/truck.png'),
                  Text("Mohon Tunggu Sebentar\nProses Download Data", 
                    textAlign: TextAlign.center,
                    style: kDefaultTextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),               
                  ),
                   LoadingAnimationWidget.prograssiveDots(
                      color: Colors.white, size: 80),
                ],
              ),
            ),
        ],
      ),
    );
  }
}