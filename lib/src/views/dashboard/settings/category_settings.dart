import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:warehouseapp/src/views/dashboard/settings/add_category.dart';
import 'category_details.dart';

class CategorySettings extends StatefulWidget {
  const CategorySettings({super.key});

  @override
  State<CategorySettings> createState() => _CategorySettingsState();
}

class _CategorySettingsState extends State<CategorySettings> {
  ProductControllers productControllers = Get.put(ProductControllers());
  @override
  void initState() {
    super.initState();
    productControllers.getCategoryItem();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        RefreshIndicator(
          onRefresh: () async {
            await productControllers.getCategoryItem();
            setState(() {});
          },
          child: GestureDetector(
            onTap: () => focusManager(),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.indigo.shade800,
                    title: Text("Category",
                      style: kDefaultTextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)
                        ),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      tooltip:
                          MaterialLocalizations.of(context).openAppDrawerTooltip,
                    ),
                  ),
                  Obx(() => productControllers.isLoading.value ? SliverList(delegate: SliverChildListDelegate([
                    Center(child: Text("Getting item....", style: kDefaultTextStyle(color: Colors.white),))
                  ])) : productControllers.categoryModels.length == 0 ? SliverList(delegate: SliverChildListDelegate([
                    Center(child: Text("Tidak ada item", style: kDefaultTextStyle(color: Colors.white),))
                  ])) :
                  SliverList.builder(
                      itemCount: productControllers.categoryModels.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onLongPress: (){
                              Get.defaultDialog(
                                title: "Hapus kategori \"${productControllers.categoryModels[index].kode} - ${productControllers.categoryModels[index].nama}\"?",
                                titleStyle: kDefaultTextStyle(),
                                titlePadding: const EdgeInsets.only(top: 10),
                                contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                                content: const Text("Apakah anda yakin menghapus kategori ini?", textAlign: TextAlign.center,),
                                barrierDismissible: false,
                                actions: [
                                  Obx(() => TextButton(
                                    onPressed: productControllers.isLoading.value ? (){} : () async {
                                      await productControllers.deleteCategory(kodeBuku : productControllers.categoryModels[index].kode).then((value){
                                        Navigator.pop(context);
                                        Get.snackbar("Berhasil", "Berhasil menghapus kategori", backgroundColor: Colors.white);
                                        productControllers.getCategoryItem();
                                      });
                                    }, 
                                    child: const Text("Ya", style: TextStyle(color: Colors.red),)),
                                  ),
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: const Text("Tidak")),
                                ]
                              );
                            },
                            onTap: () {
                              Get.to(() => const CategoryDetails());
                            },
                            shape: RoundedRectangleBorder(
                              //<-- SEE HERE
                              side: const BorderSide(width: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tileColor: Colors.white60,
                            title: Text(
                              "${productControllers.categoryModels[index].kode} - ${productControllers.categoryModels[index].nama}",
                              style: kDefaultTextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCategooryPage()));
                },
                backgroundColor: Colors.indigo.shade800,
                shape: const CircleBorder(),
                elevation: 0,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
