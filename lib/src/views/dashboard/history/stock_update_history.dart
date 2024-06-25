import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/custom_style/dashed_line.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class UpdateStockHistoryPage extends StatefulWidget {
  const UpdateStockHistoryPage({super.key});

  @override
  State<UpdateStockHistoryPage> createState() => _UpdateStockHistoryPageState();
}

class _UpdateStockHistoryPageState extends State<UpdateStockHistoryPage> {
  ProductControllers productControllers = Get.find();
  
  @override
  void initState() {
    super.initState();
    productControllers.getUpdateStockHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            appBar: kDefaultAppBar(context, title: "History Update Stok"),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Obx(() => productControllers.isLoading.value ? Container() : 
              productControllers.resultUpdateStockHistory.length == 0 ? const Column(
                children: [
                  Text("Tidak ada riwayat")
                ],
              ) : Column(
                  children: List.generate(productControllers.resultUpdateStockHistory.length, (index) {
                    return GestureDetector(
                        onTap: (){
                          // Get.to(() =>  UpdateStockDetail(indexItem: index, idProduct: productControllers.resultInvoice[index]['id']));
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
                              Text(productControllers.resultUpdateStockHistory[index]['item']['nama'] ?? 'Unknown Name', style: kDefaultTextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              const MySeparator(),
                              const SizedBox(height: 4),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text("Transaction Date : "),
                                      Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(productControllers.resultUpdateStockHistory[index]['transaction_date'] ?? DateTime.now())), style: kDefaultTextStyle(fontSize: 13),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Menambah stok sebanyak : "),
                                      Text("${productControllers.resultUpdateStockHistory[index]['jumlah_item_update'].toString()} pcs", style: kDefaultTextStyle(fontSize: 13),),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Notes : "),
                                      Expanded(child: Text(productControllers.resultUpdateStockHistory[index]['notes'] ?? 'No descriptions', style: kDefaultTextStyle(fontSize: 14, fontWeight: FontWeight.normal),)),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.green,
                                        child: Text(productControllers.resultUpdateStockHistory[index]['vendor']['nama'].toString()[0].toUpperCase(), style: kDefaultTextStyle(color: Colors.white),),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(productControllers.resultUpdateStockHistory[index]['vendor']['nama'] ?? 'Unknown name')
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                  },)
                ),
              ),
            ),
          ),
        ),
        Obx(() => productControllers.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }
}