import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/custom_style/dashed_line.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:warehouseapp/src/views/dashboard/item/item_detail.dart';

class UpdateStockDetail extends StatefulWidget {
  const UpdateStockDetail({super.key});

  @override
  State<UpdateStockDetail> createState() => _UpdateStockDetailState();
}

class _UpdateStockDetailState extends State<UpdateStockDetail> {
  String? datePickedOrder;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            appBar: kDefaultAppBar(
              context, 
              title: "Update Stock Detail",
              actions: [
                IconButton(
                  onPressed: (){}, 
                  icon: const Icon(Icons.delete, color: Colors.white))
              ], 
              withAction: true
            ),
            backgroundColor: Colors.transparent,
            body:  SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white60
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Stock Flow"),
                                  Container(
                                    color: Colors.transparent,
                                    child: const Row(
                                      children: [
                                        Icon(Icons.arrow_upward, color: Colors.black87, size: 15),
                                        Text("3.0"),
                                      ]
                                    ),
                                  ),
                                  Text(DateFormat('dd/MM/yyyy').format(DateTime.now()))
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Items"),
                                  Text("1")
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const MySeparator(),
                        const SizedBox(height: 4),
                        const Text("Buku Fiksi Harry Potter"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                      onTap: (){
                        Get.to(() => const ItemDetail(
                          stockLength: 5,
                          title: "F01 - SwiftUI for Beginner",
                          category: "Novel",
                        ));
                      },
                      shape: RoundedRectangleBorder( //<-- SEE HERE
                        side: const BorderSide(width: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: Colors.white60,
                      leading: Container(
                        color: Colors.transparent,
                        width: 35,
                        height: 35,
                        child: const Icon(Icons.image_outlined, color: Colors.black87, size: 40,)
                      ),
                      trailing: const Text("5"),                            
                      title: Text("F01 - SwiftUI for Beginner", overflow: TextOverflow.ellipsis, style: kDefaultTextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                      subtitle: Row(
                        children: [
                          const Icon(Icons.folder_open, size: 20),
                          const SizedBox(width: 3),
                          Text("Novel", style: kDefaultTextStyle(fontSize: 11))
                        ],
                      ),
                  ),
                ],
              ),
            )
          ),
        ),
      ],
    );
  }
}