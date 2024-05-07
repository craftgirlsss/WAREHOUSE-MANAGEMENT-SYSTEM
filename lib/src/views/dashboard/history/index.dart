import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/custom_style/dashed_line.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

import 'update_stock_detail.dart';

class StockHistory extends StatefulWidget {
  const StockHistory({super.key});

  @override
  State<StockHistory> createState() => _StockHistoryState();
}

class _StockHistoryState extends State<StockHistory> {
  String? datePickedOrder;
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
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) => 
                    GestureDetector(
                      onTap: (){
                        Get.to(() => const UpdateStockDetail());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white60
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("NF$index - Mengenal Tata Surya Vol-${index+1}", style: kDefaultTextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            const MySeparator(),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2024), //get today's date
                                      firstDate:DateTime(2023), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime.now()
                                    );
                                    if(pickedDate != null ){                      
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                      setState(() {
                                          datePickedOrder = formattedDate; //set foratted date to TextField value. 
                                      });
                                    }
                                  }, 
                                  icon: const Icon(CupertinoIcons.calendar, color: Colors.black, size: 20,), 
                                  label: Text(DateFormat('dd/MM/yyyy').format(datePickedOrder != null ? DateTime.parse(datePickedOrder!) 
                                    : DateTime.now()), style: kDefaultTextStyle(fontSize: 13),),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  child: const Row(
                                    children: [
                                      Icon(Icons.arrow_upward, color: Colors.black87, size: 15),
                                      Text("3.0")
                                    ]
                                  ),
                                )
                              ],
                            ),
                            const Row(
                              children: [
                                CircleAvatar(
                                  radius: 14,
                                  backgroundColor: GlobalVariable.mainColor,
                                  child: Text("A"),
                                ),
                                SizedBox(width: 5),
                                Text("PT Adi Jaya Makmur")
                              ],
                            )
                          ],
                        ),
                      ),
                    )
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