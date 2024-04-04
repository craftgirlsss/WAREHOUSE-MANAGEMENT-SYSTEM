import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/global_variable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: GlobalVariable.defaultPadding,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.8,
            padding: GlobalVariable.defaultPadding,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              children: [
                ListTile(),
                Row(
                  children: [
                    Column(),
                    Column()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}