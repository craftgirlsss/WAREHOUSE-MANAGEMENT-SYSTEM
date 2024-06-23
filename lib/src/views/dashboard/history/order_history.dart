import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/custom_style/dashed_line.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'update_stock_detail.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  ProductControllers productControllers = Get.find();
  String? datePickedOrder;

  @override
  void initState() {
    productControllers.stockHistory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            appBar: kDefaultAppBar(context, title: "Order History"),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Obx(() => productControllers.isLoading.value ? Container() : 
                  productControllers.resultInvoice.isEmpty ? 
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Center(
                      child: Text("Tidak ada data", style: kDefaultTextStyle(color: Colors.white, fontSize: 17),),
                    ),
                  ) : ListView.builder(
                      itemCount: productControllers.resultInvoice.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) => 
                      GestureDetector(
                        onTap: (){
                          Get.to(() =>  UpdateStockDetail(indexItem: index, idProduct: productControllers.resultInvoice[index]['id']));
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
                              Text(productControllers.resultInvoice[index]['item']['nama'], style: kDefaultTextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              const MySeparator(),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: (){},
                                    icon: const Icon(CupertinoIcons.calendar, color: Colors.black, size: 20,), 
                                    label: Column(
                                      children: [
                                        const Text("Order"),
                                        Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(productControllers.resultInvoice[index]['tanggal_order'])), style: kDefaultTextStyle(fontSize: 13),),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: (){},
                                    icon: const Icon(CupertinoIcons.calendar, color: Colors.black, size: 20,), 
                                    label: Column(
                                      children: [
                                        const Text("Jatuh Tempo"),
                                        Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(productControllers.resultInvoice[index]['tanggal_tagihan'])), style: kDefaultTextStyle(fontSize: 13),),
                                      ],
                                    ),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundColor: GlobalVariable.mainColor,
                                        child: Text(productControllers.resultInvoice[index]['customer']['nama_perusahaan'].toString()[0]),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(productControllers.resultInvoice[index]['customer']['nama_perusahaan'] ?? 'Unknown')
                                    ],
                                  ),
                                  if(productControllers.resultInvoice[index]['status'] == 0)
                                    const Text("Status : Diperjalanan")
                                  else if(productControllers.resultInvoice[index]['status'] == 1)
                                    const Text("Status : Diterima")
                                  else
                                    const Text("Status : Di Proses")
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
        Obx(() => productControllers.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }
}