import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/dialogs/cupertino_dialogs.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:warehouseapp/src/views/dashboard/item/add_item.dart';

import 'item_detail.dart';

class ItemsPage extends StatefulWidget {
  final bool withAppBar;
  const ItemsPage({super.key, required this.withAppBar});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  ProductControllers productControllers = Get.put(ProductControllers());

  @override
  void initState() {
    super.initState();
  }

  String? datePicked;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: RefreshIndicator(
            onRefresh: ()async{
              await productControllers.fetchProductItems();
              setState(() {});
            },
            child: Scaffold(
              appBar: widget.withAppBar == false 
              ? null 
              : kDefaultAppBar(context, title: "All Items", 
              withAction: true, 
              actions: [IconButton(onPressed: (){
                 Get.to(() => const AddItems());
              }, icon: const Icon(Icons.add, color: Colors.white,))]),
              backgroundColor: Colors.transparent,
              body: Obx(
                () => productControllers.isLoading.value 
                ? floatingLoading() 
                : productControllers.productModels.length == 0 || productControllers.productModels.isEmpty ?
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/empty.png', width: 200),
                        const Text("Tidak ada items tersedia", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ) : CustomScrollView(
                  slivers: [
                    SliverList.builder(
                      itemCount: productControllers.itemCountLength.value,
                      itemBuilder: (context, index){
                        if(productControllers.itemCountLength.value == 0){
                          return Center(
                            child: Container(
                              color: Colors.transparent,
                              width: double.infinity,
                              height: double.infinity,
                              child: const Text("Tidak ada data buku", style: TextStyle(color: Colors.white),),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onLongPress: ()async{
                              showMyDialog(
                                content: "Apakah anda yakin menghapus item?",
                                context: context,
                                onPressed: () async {
                                  Navigator.pop(context);
                                  productControllers.deleteItems(productControllers.productModels[index].id!).then((value){
                                    if(value){
                                      productControllers.fetchProductItems().then((value) {
                                        Get.snackbar('Berhasil', "Berhasil menghapus item", backgroundColor: Colors.white);
                                        Navigator.pop(context);
                                      });
                                    }else{
                                      Get.snackbar('Gagal', "Gagal menghapus item", backgroundColor: Colors.white);
                                    }
                                  }); 
                                },
                                title: "Hapus Item"
                              );
                            },
                              child: ListTile(
                                onTap: (){
                                  Get.to(() => ItemDetail(
                                    id: productControllers.productModels[index].id,
                                    idCategory: productControllers.productModels[index].toko?.id,
                                    penerbit: productControllers.productModels[index].penerbit,
                                    sellingPrice: productControllers.productModels[index].hargaJual,
                                    hargaBeli: productControllers.productModels[index].hargaBeli,
                                    sku: productControllers.productModels[index].sku,
                                    stockLength: productControllers.productModels[index].jumlahStockSaatIni,
                                    title: productControllers.productModels[index].nama,
                                    category: productControllers.productModels[index].toko?.nama,
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
                                trailing: Text(productControllers.productModels[index].jumlahStockSaatIni != null ? productControllers.productModels[index].jumlahStockSaatIni.toString() : "0"),                            
                                title: Text(productControllers.productModels[index].nama ?? 'Unknown', overflow: TextOverflow.ellipsis, style: kDefaultTextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                subtitle: Row(
                                  children: [
                                    const Icon(Icons.folder_open, size: 20),
                                    const SizedBox(width: 3),
                                    Text(productControllers.productModels[index].toko?.nama ?? 'Uknown', style: kDefaultTextStyle(fontSize: 11))
                                  ],
                                ),
                              ),
                            ),
                        );
                      }, 
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