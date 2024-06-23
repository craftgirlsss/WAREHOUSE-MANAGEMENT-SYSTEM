import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/custom_style/dashed_line.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:warehouseapp/src/views/dashboard/item/item_detail.dart';

class UpdateStockDetail extends StatefulWidget {
  final int? idProduct;
  final int? indexItem;
  const UpdateStockDetail({super.key, this.idProduct, this.indexItem});

  @override
  State<UpdateStockDetail> createState() => _UpdateStockDetailState();
}

class _UpdateStockDetailState extends State<UpdateStockDetail> {
  double itemExtent = 32.0;
  List<String> statusList = <String>['Diproses', 'Diperjalanan', 'Diterima'];
  ProductControllers productControllers = Get.find();
  String? datePickedOrder;
  int selecteStatus = 1;

  void showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    print(productControllers.resultInvoice[widget.indexItem!]['item']['kategori']['nama']);
    return Stack(
      children: [
        backgroundColor(context),
        PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            productControllers.stockHistory();
          },
          child: GestureDetector(
            onTap: () => focusManager(),
            child: Scaffold(
              appBar: kDefaultAppBar(
                context, 
                title: "History Details",
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
                                    Text("Tanggal Order : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(productControllers.resultInvoice[widget.indexItem!]['tanggal_order']))}")
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text("Jumlah Pembelian"),
                                    Text("${productControllers.resultInvoice[widget.indexItem!]['jumlah_buku'].toString()} pcs", style: const TextStyle(fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const MySeparator(),
                          const SizedBox(height: 4),
                          Text("No. PO : ${productControllers.resultInvoice[widget.indexItem!]['nomor_po']}"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                        onTap: (){
                          Get.to(() => ItemDetail(
                            penerbit: productControllers.resultInvoice[widget.indexItem!]['item']['penerbit'],
                            costPrice: productControllers.resultInvoice[widget.indexItem!]['item']['harga_beli'].toDouble(),
                            sellingPrice: productControllers.resultInvoice[widget.indexItem!]['item']['harga_jual'],
                            sku: productControllers.resultInvoice[widget.indexItem!]['item']['sku'],
                            stockLength: productControllers.resultInvoice[widget.indexItem!]['item']['jumlah_stock_saat_ini'],
                            title: productControllers.resultInvoice[widget.indexItem!]['item']['nama'],
                            category: productControllers.resultInvoice[widget.indexItem!]['item']['kategori']['nama'],
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
                        trailing: Text("Sisa Stok ${productControllers.resultInvoice[widget.indexItem!]['item']['jumlah_stock_saat_ini'].toString()}"),
                        title: Text(productControllers.resultInvoice[widget.indexItem!]['item']['nama'], overflow: TextOverflow.ellipsis, style: kDefaultTextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                        subtitle: Row(
                          children: [
                            const Icon(Icons.folder_open, size: 20),
                            const SizedBox(width: 3),
                            Text(productControllers.resultInvoice[widget.indexItem!]['item']['kategori']['nama'], style: kDefaultTextStyle(fontSize: 11))
                          ],
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green
                            ),
                            onPressed: (){
                            }, child: const Text("Lihat Invoice", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                          const SizedBox(width: 10),
                          Expanded(child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple
                            ),
                            onPressed: (){
                              showDialog(
                                CupertinoPicker(
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  useMagnifier: true,
                                  itemExtent: itemExtent,
                                  scrollController: FixedExtentScrollController(
                                    initialItem: selecteStatus,
                                  ),
                                  onSelectedItemChanged: (int selectedItem) async {
                                    int? result;
                                    setState(() {
                                      selecteStatus = selectedItem;
                                    });
                                    if(selecteStatus == 2) {result = 1;}
                                    else if(selecteStatus == 1) {result = 0;}
                                    else {result = -1;}
                                    print("ini selecteStatus  = $selecteStatus");
                                    await productControllers.updateStatusHistoryItem(id: widget.idProduct, status: result);
                                  },
                                  children: List<Widget>.generate(statusList.length, (int index) {
                                    return Center(child: Text(statusList[index]));
                                  }),
                                ),
                              );
                            }, child: const Text("Ubah Status", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ),
          ),
        ),
      ],
    );
  }
}