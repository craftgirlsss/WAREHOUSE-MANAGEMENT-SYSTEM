import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/views/login/login.dart';
import 'package:warehouseapp/src/views/mainpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    permissionServiceCall(context);
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getBool('loggedIn') == true){
        Get.off(() => const MainPage());
      }else{
        Get.off(() => const LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backgroundColor(context),
          SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/json/splash.json', 
                      frameRate: const FrameRate(60), 
                      width: 200, 
                      repeat: false,
                    )
                  ),
                ],
            ),
          ),
        ],
      ),
    );
  }

  Future permissionServiceCall(BuildContext context) async {  
    final permissionStatusStorage = await Permission.storage.status;
    if (permissionStatusStorage.isDenied) {
        await Permission.storage.request();
    } else if (permissionStatusStorage.isPermanentlyDenied) {
        await openAppSettings();
    } else {
      print(permissionStatusStorage);
    }
    
    final permissionStatusCamera = await Permission.camera.status;
    if (permissionStatusCamera.isDenied) {
        await Permission.camera.request();
    } else if (permissionStatusCamera.isPermanentlyDenied) {
        await openAppSettings();
    } else {
      print(permissionStatusCamera);
    }

    final permissionStatusPhotos = await Permission.photos.status;
    if (permissionStatusPhotos.isDenied) {
        await Permission.photos.request();
    } else if (permissionStatusPhotos.isPermanentlyDenied) {
        await openAppSettings();
    } else {
      print(permissionStatusPhotos);
    }
  }
}