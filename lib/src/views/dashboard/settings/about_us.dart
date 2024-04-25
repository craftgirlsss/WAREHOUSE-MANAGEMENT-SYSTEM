import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class AboutUSPage extends StatefulWidget {
  const AboutUSPage({super.key});

  @override
  State<AboutUSPage> createState() => _AboutUSPageState();
}

class _AboutUSPageState extends State<AboutUSPage> {
 
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: kDefaultAppBar(context, title: "About us"),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.8,
                      height: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        image: const DecorationImage(image: AssetImage('assets/icons/ic_launcher.png'), fit: BoxFit.contain)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, right:  20),
                      child: Text("Droidify adalah aplikasi warehouse management system for book logistics industry merupakan sebuah aplikasi untuk memonitoring dan manajemen buku yang keluar dan masuk dari gudang agar lebih mudah pemantauanya. Aplikasi ini dilengkapi oleh beberapa fitur yang mendukung.", textAlign: TextAlign.center, style: kDefaultTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.copyright_rounded, size: 30, color: Colors.white),
                    const SizedBox(width: 7),
                    Text("Droidfy 2024", style: kDefaultTextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal),)
                  ],
                ),
              )
            )
          ),
      ],
    );
  }
}

enum Dataperson{
  customer,
  vendor
}