import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

import '../update_stock/adding_contact_page.dart';
import 'tile_items_add_feature.dart';

class SelectItems extends StatefulWidget {
  const SelectItems({super.key});

  @override
  State<SelectItems> createState() => _SelectItemsState();
}

class _SelectItemsState extends State<SelectItems> {
  ProductControllers productControllers = Get.find();
  
  @override
  void initState() {
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
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              onRefresh: () async {
                await productControllers.fetchProductItems();
                setState(() {
                  print("Done");
                });
              },
              child:  Obx(
                () => productControllers.productModels.length == 0 ? const SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Produk item kosong"),
                      ],
                    ),
                  ),
                ) : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.indigo.shade800,
                        title: Text("Select Items", style: kDefaultTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
                              onPressed: (){
                              Get.to(() => const AddingContactPage());
                            }, child: Text("Add Contact", style: kDefaultTextStyle(color: Colors.white),))
                        ],
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(60), 
                          child: Padding(
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
                                        hintText: "Search Item Name",
                                        prefixIcon: const Icon(CupertinoIcons.search),
                                        hintStyle: kDefaultTextStyle(),                                
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25)
                                        )
                                      ),
                                    ),
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverList.builder(
                        itemCount: productControllers.productModels.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => SelectAndAddItems(
                                onPressed: productControllers.isLoading.value ? (){} : (){
                                  productControllers.itemNameSelected.value = productControllers.productModels[index].nama!;
                                  productControllers.idItemSelected.value = productControllers.productModels[index].id!;
                                  productControllers.priceBook.value = productControllers.productModels[index].hargaBeli!;
                                  Navigator.pop(context);
                                },
                                subtitleJumlahBuku: productControllers.productModels[index].stockAwal,
                                title: "${productControllers.productModels[index].toko?.kode} - ${productControllers.productModels[index].nama}",
                                item: productControllers.productModels[index].stockAwal,
                              ),
                            )
                          );
                        }, 
                      )
                    ],
                  ),
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