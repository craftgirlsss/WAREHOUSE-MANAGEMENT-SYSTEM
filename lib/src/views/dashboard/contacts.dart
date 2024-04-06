import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kDefaultAppBar(
        context,
        title: "Contact",
        withAction: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.add, color: Colors.white))
        ]
      ),
      body: Stack(
        children: [
          backgroundColor(context)
        ],
      ),
    );
  }
}