import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

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
              : kDefaultAppBar(context, title: "All Items"),
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
                    SliverAppBar(
                      backgroundColor: Colors.indigo.shade800,
                      leadingWidth: 0,
                      titleSpacing: 0,
                      automaticallyImplyLeading: false,
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  style: kDefaultTextStyle(),
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 3),
                                    hintText: "Search Items",
                                    prefixIcon: const Icon(CupertinoIcons.search),
                                    hintStyle: kDefaultTextStyle(),                                
                                    filled: true,
                                    fillColor: Colors.white60,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25)
                                    )
                                  ),
                                ),
                              )
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                color: Colors.transparent,
                                child: const Row(
                                  children: [
                                    Icon(CupertinoIcons.arrow_up_down,size: 25,
                                      color: Colors.white,),
                                    Icon(CupertinoIcons.text_alignleft, size: 25,
                                      color: Colors.white,)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverList.builder(
                      itemCount: productControllers.productModels.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              onTap: (){
                                Get.to(() => ItemDetail(
                                  id: productControllers.productModels[index].id,
                                  idCategory: productControllers.productModels[index].toko?.id,
                                  penerbit: productControllers.productModels[index].penerbit,
                                  sellingPrice: productControllers.productModels[index].hargaJual,
                                  costPrice: productControllers.productModels[index].hargaJual != null && productControllers.productModels[index].hargaBeli != null ? ((productControllers.productModels[index].hargaJual! - productControllers.productModels[index].hargaBeli!) * 0.15) : 0,
                                  sku: productControllers.productModels[index].sku,
                                  stockLength: productControllers.productModels[index].stockAwal,
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
                              trailing: Text(productControllers.productModels[index].stockAwal != null ? productControllers.productModels[index].stockAwal.toString() : "0"),                            
                              title: Text(productControllers.productModels[index].nama ?? 'Unknown', overflow: TextOverflow.ellipsis, style: kDefaultTextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              subtitle: Row(
                                children: [
                                  const Icon(Icons.folder_open, size: 20),
                                  const SizedBox(width: 3),
                                  Text(productControllers.productModels[index].toko?.nama ?? 'Uknown', style: kDefaultTextStyle(fontSize: 11))
                                ],
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