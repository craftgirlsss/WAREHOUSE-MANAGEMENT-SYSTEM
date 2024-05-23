import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:warehouseapp/src/components/global_variable.dart' as vars;
import 'package:warehouseapp/src/views/login/login.dart';
import 'about_us.dart';
import 'category_settings.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String? datePicked;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder( //<-- SEE HERE
                    side: const BorderSide(width: 0.2),
                    borderRadius: BorderRadius.circular(13),
                  ),
                    tileColor: Colors.white.withOpacity(0.7),
                    onTap: (){
                      Get.to(() => const CategorySettings());
                    },
                    leading: const Icon(Icons.folder, size: 35),
                    title: const Text("Category"),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    shape: RoundedRectangleBorder( //<-- SEE HERE
                    side: const BorderSide(width: 0.2),
                    borderRadius: BorderRadius.circular(13),
                  ),
                    tileColor: Colors.white.withOpacity(0.7),
                    onTap: (){
                      Get.to(() => const AboutUSPage());
                    },
                    leading: const Icon(CupertinoIcons.info, size: 35),
                    title: const Text("About us"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: (){
                      _showMyDialog();
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0
                    ),
                    icon: const Icon(Icons.power_settings_new_rounded, size: 45, color: Colors.white,), 
                    label: const Text("Logout", style: TextStyle(fontSize: 25, color: Colors.white),))
                ],
              ),
            )
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Apakah anda yakin ingin keluar?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('YA'),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('loggedIn');
              await vars.client.auth.signOut().then((value) {                
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false); 
              });
            },  
          ),
          TextButton(
            child: const Text('TIDAK'),
            onPressed: () {
              Navigator.of(context).pop();
            },  
          ),
        ],
      );
    },
  );
}
}