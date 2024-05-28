import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:warehouseapp/src/helpers/connections/connections_for_android_7_above.dart';
import 'package:warehouseapp/src/views/splashscreen/splashscreen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = CertificateNetwork();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await Supabase.initialize(
    url: 'https://cgwedpervqbywpyjftzu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNnd2VkcGVydnFieXdweWpmdHp1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDYyNTgwMTYsImV4cCI6MjAyMTgzNDAxNn0.NmjnWZg_tq728Zuz4Wlnrrd8oBA4PlflIyYAQ6MrExw',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //top status bar
        systemNavigationBarColor: Colors.indigo.withOpacity(0.03), // navigation bar color, the one Im looking for
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarDividerColor: Colors.indigo.withOpacity(0.03),
        systemNavigationBarIconBrightness:
            Brightness.dark, //navigation bar icons' color
      ),
      child: GetMaterialApp(
        title: 'Warehouse App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
