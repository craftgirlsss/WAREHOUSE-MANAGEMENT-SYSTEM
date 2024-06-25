import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:warehouseapp/src/views/dashboard/history/order_history.dart';
import 'package:warehouseapp/src/views/dashboard/history/stock_update_history.dart';

class SelectHistoryPage extends StatefulWidget {
  const SelectHistoryPage({super.key});

  @override
  State<SelectHistoryPage> createState() => _SelectHistoryPageState();
}

class _SelectHistoryPageState extends State<SelectHistoryPage> {
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
                  FittedBox(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const UpdateStockHistoryPage());
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width / 2,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white60
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Icon(CupertinoIcons.tray_arrow_up_fill, size: 40, color: Colors.black),
                                  SizedBox(height: 6),
                                  Text("Update Stock History", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const OrderHistory());
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width / 2,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white60
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Icon(CupertinoIcons.tray_arrow_down_fill, size: 40, color: Colors.black),
                                  SizedBox(height: 6),
                                  Text("Order History", style: TextStyle(fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]
              ),
            ),
          ),
        ),
      ],
    );
  }
}