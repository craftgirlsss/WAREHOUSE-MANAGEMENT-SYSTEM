import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class EditItem extends StatefulWidget {
  final String? namaItem;
  final String? skuItem;
  final int? id;
  final int? idCategory;
  final int? openingStockItem;
  final String? namaPenerbitItem;
  final String? categoryItem;
  final int? hargaPenjualanItem;
  final double? biayaItem;
  const EditItem({super.key, this.namaItem, this.skuItem, this.openingStockItem, this.namaPenerbitItem, this.categoryItem, this.hargaPenjualanItem, this.biayaItem, this.idCategory, this.id});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  ProductControllers productControllers = Get.find();
  TextEditingController namaItemController = TextEditingController();
  TextEditingController skuItemController = TextEditingController();
  TextEditingController openingStockItemController = TextEditingController();
  TextEditingController namaPenerbitItemController = TextEditingController();
  TextEditingController categoryItemController = TextEditingController();
  TextEditingController hargaPenjualanItemController = TextEditingController();
  TextEditingController biayaItemController = TextEditingController();
  int? categoryID;

  @override
  void initState() {
    super.initState();
    categoryID = widget.idCategory;
    namaItemController.text = widget.namaItem ?? 'Unknown';
    skuItemController.text = widget.skuItem ?? 'Unknown';
    openingStockItemController.text = widget.openingStockItem.toString();
    namaPenerbitItemController.text = widget.namaPenerbitItem ?? 'Unknown';
    categoryItemController.text = widget.categoryItem ?? 'Unknown';
    hargaPenjualanItemController.text = widget.hargaPenjualanItem.toString();
    biayaItemController.text = widget.biayaItem!.toInt().toString();
  }

  @override
  void dispose() {
    namaItemController.dispose();
    skuItemController.dispose();
    openingStockItemController.dispose();
    namaPenerbitItemController.dispose();
    categoryItemController.dispose();
    hargaPenjualanItemController.dispose();
    biayaItemController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.indigo.shade800,
              title: Text("Edit Item", style: kDefaultTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 25,
                color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
                actions: [
                  TextButton(
                    onPressed: () async {
                    if(await productControllers.editProductItems(
                      category: categoryID,
                      hargaPenjaualan: int.parse(hargaPenjualanItemController.text),
                      namaItem: namaItemController.text,
                      namaPenerbitItem: namaPenerbitItemController.text,
                      openingStock: int.parse(openingStockItemController.text),
                      id: widget.id,
                      sku: skuItemController.text
                    )){
                      Get.snackbar("Berhasil", "Berhasil mengupdate item", backgroundColor: Colors.white);
                      Future.delayed(const Duration(seconds: 1), (){
                        productControllers.fetchProductItems();
                        Navigator.pop(context);
                      });
                    }else{
                      Get.snackbar("Gagal", "Gagal merubah data", backgroundColor: Colors.white);
                    }
                    
                  }, child: Text("Save", style: kDefaultTextStyle(color: Colors.white),))
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white60,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: namaItemController,
                          decoration: const InputDecoration(
                            label: Text("Nama Item"),
                          ),
                        ),
                        TextField(
                          controller: skuItemController,
                          decoration: const InputDecoration(
                            label: Text("SKU"),
                          ),
                        ),
                        TextField(
                          controller: openingStockItemController,
                          decoration: const InputDecoration(
                            label: Text("Opening Stock"),
                          ),
                        ),
                        TextField(
                          controller: namaPenerbitItemController,
                          decoration: const InputDecoration(
                            label: Text("Nama Penerbit"),
                          ),
                        ),
                        TextField(
                          controller: categoryItemController,
                          readOnly: true,
                          onTap: () async {
                            productControllers.getCategoryItem();
                            Get.defaultDialog(
                              backgroundColor: Colors.white,
                              title: "Daftar Kategori",
                              titleStyle: kDefaultTextStyle(color: Colors.black, fontSize: 16),
                              titlePadding: const EdgeInsets.only(top: 15),
                              content: Obx(
                                () => productControllers.isLoading.value ? Center(
                                  child: floatingLoading(),
                                ) : productControllers.categoryModels.length == 0 ? Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(CupertinoIcons.person_2_square_stack, color: Colors.black,),
                                      Text("Tidak ada akun real", style: kDefaultTextStyle(color: Colors.black),)
                                    ],
                                  ),
                                ) : 
                                SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                      productControllers.categoryModels.length, (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: ListTile(
                                              tileColor: Colors.black12,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(7)
                                              ),
                                              dense: true,
                                              title: Text(productControllers.categoryModels[index].nama ?? 'Unknown', style: kDefaultTextStyle(color: Colors.black, fontSize: 14),),
                                              onTap: () async {
                                                setState(() {
                                                  categoryItemController.text = productControllers.categoryModels[index].nama!;
                                                  categoryID = productControllers.categoryModels[index].id;
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          );
                                        }
                                    )
                                  ),
                                ),
                              )
                            );
                          },
                          decoration: InputDecoration(
                            label: const Text("Category"),
                            suffixIcon: IconButton(
                              onPressed: (){
                                
                              }, 
                              icon: const Icon(Icons.add)
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white60,
                    ),
                    child: Row(
                      children: [
                        Expanded(child: 
                          TextField(
                            controller: hargaPenjualanItemController,
                            decoration: const InputDecoration(
                              label: Text("Harga Penjualan"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(child: 
                          TextField(
                            controller: biayaItemController,
                            decoration: const InputDecoration(
                              label: Text("Biaya"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Obx(() => productControllers.isLoading.value ? floatingLoading() : const SizedBox())
      ],
    );
  }
}