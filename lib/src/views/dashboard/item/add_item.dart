import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class AddItems extends StatefulWidget {
  const AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  ProductControllers productControllers = Get.find();
  TextEditingController namaItemController = TextEditingController();
  TextEditingController skuItemController = TextEditingController();
  TextEditingController openingStockItemController = TextEditingController();
  TextEditingController namaPenerbitItemController = TextEditingController();
  TextEditingController categoryItemController = TextEditingController();
  TextEditingController hargaPenjualanItemController = TextEditingController();
  TextEditingController biayaItemController = TextEditingController();
  TextEditingController hargaBeliItemController = TextEditingController();
  TextEditingController stockMinimal = TextEditingController();
  int? categorySelected;

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
              title: Text("Add Item", style: kDefaultTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
                      if(namaItemController.text.isEmpty 
                      || categoryItemController.text.isEmpty
                      || hargaPenjualanItemController.text.isEmpty
                      || namaPenerbitItemController.text.isEmpty
                      || openingStockItemController.text.isEmpty
                      || namaPenerbitItemController.text.isEmpty
                      || skuItemController.text.isEmpty
                      || hargaBeliItemController.text.isEmpty
                      || stockMinimal.text.isEmpty
                      ){
                        Get.snackbar("Gagal", "Mohon isi semua field yang tersedia", backgroundColor: Colors.white);
                      }else{
                        if(await productControllers.addProductItems(
                          category: categorySelected,
                          hargaPenjaualan: int.parse(hargaPenjualanItemController.text),
                          namaItem: namaItemController.text,
                          namaPenerbitItem: namaPenerbitItemController.text,
                          openingStock: int.parse(openingStockItemController.text),
                          penerbit: namaPenerbitItemController.text,
                          sku: skuItemController.text
                        )){
                          Get.snackbar("Berhasil", "Berhasil menambah item", backgroundColor: Colors.white);
                          Future.delayed(const Duration(seconds: 1), (){
                            productControllers.fetchProductItems();
                            Navigator.pop(context);
                          });
                        }
                      }
                  },
                  child: Text("Save", style: kDefaultTextStyle(color: Colors.white),))
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage('assets/images/empty_image.png'), fit: BoxFit.cover)
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: (){},
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                                ),
                                child: const Icon(CupertinoIcons.camera_fill, color: Colors.black54),
                              ),
                            ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
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
                          keyboardType: TextInputType.number,
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
                          onTap: (){
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
                                                  categorySelected = productControllers.categoryModels[index].id;
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
                              onPressed: (){}, 
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
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
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  label: Text("Biaya"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: 
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: hargaBeliItemController,
                                decoration: const InputDecoration(
                                  label: Text("Harga Beli"),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(child: 
                              TextField(
                                controller: stockMinimal,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  label: Text("Stock Minimal"),
                                ),
                              ),
                            ),
                          ],
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